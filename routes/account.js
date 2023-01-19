const express = require("express");
const asyncMySQL = require("../mysql/connection");
const {
  getUserCreds,
  insertUserToken,
  insertUserTokenConnection,
  createUser,
  createCompany,
  connectUserCompany,
  deleteFrom,
  update,
} = require("../mysql/query");

const router = express.Router();
const sha256 = require("sha256");
const { addToken, getTokenCreds } = require("../middleware/tokens");
const { genToken } = require("../utils");
const { runQuery } = require("../utils/sql");

router.put("/logout", async function (req, res) {
  await asyncMySQL();

  res.send({ status: 1 });
});

router.put("/login", async function (req, res) {
  const { email, password } = req.body;

  if (!email || !password) {
    res.send({ status: 1, error: "credentials not sent" });
    return;
  }

  try {
    //Get rest of users details via joining
    const user = await asyncMySQL(getUserCreds(["password", "id"], "email"), [
      email,
    ]);

    const shaPass = sha256(`${process.env.SALT}${password}`);

    if (!user[0] || shaPass !== user[0].password) {
      //Add some sort of check here to catch brute force
      res.send({ status: 2 });
      return;
    }

    const token = genToken();

    const { tokenId } = getTokenCreds(email);

    const result = await runQuery(
      update("tokens", [["token", `'${token}'`]], ["id", tokenId])
    );

    if (!result) {
      console.log("error logging user in");
      res.status(500).send();
    }

    addToken(email, {
      userId: user[0].id,
      token,
      tokenId: tokenId,
    });

    res.send({
      status: 1,
      token,
      email,
    });
    
  } catch (error) {
    console.log("log in route error: ", error);
    res.send({ status: -1, error: "Login failed" });
  }
});

router.put("/register", async function (req, res) {
  const {
    email,
    password,
    company,
    companyStreet,
    companyCity,
    companyCounty,
    companyPostcode,
    companyCountry,
    pricePlan,
  } = req.body.data;

  if (
    !email ||
    !password ||
    !company ||
    !companyStreet ||
    !companyCity ||
    !companyCounty ||
    !companyPostcode ||
    !companyCountry ||
    typeof pricePlan !== "number"
  ) {
    res.send({ status: 0, error: "Invalid registration" });
  }

  const { insertId: userId } = await runQuery(createUser(), [
    email,
    sha256(`${process.env.SALT}${password}`),
  ]);

  const { insertId: companyId } = await runQuery(createCompany(), [
    company,
    companyStreet,
    companyCity,
    companyCounty,
    companyPostcode,
    companyCountry,
  ]);

  if (!userId || !companyId) {
    console.log("failed to insert user or company on registration");
    res.status(500).send({ status: 0 });
    return;
  }

  const userCompRes = await runQuery(connectUserCompany(), [userId, companyId]);

  if (!userCompRes) {
    //We don't need to destruct anything out of this, so just make sure we were success
    console.log("failed to connect user to company on registration");
    res.status(500).send({ status: 0 });
    return;
  }

  const token = genToken();

  const { insertId: tokenId } = await runQuery(insertUserToken(), [token]);

  const { insertId: connection } = await runQuery(insertUserTokenConnection(), [
    userId,
    tokenId,
  ]);

  addToken(email, {
    userId,
    token,
    tokenId,
    connection,
  });

  res.send({
    status: 1,
    data: {
      user: { email, token, authenticated: true },
      company: {
        name: company,
        street: companyStreet,
        city: companyCity,
        county: companyCounty,
        postcode: companyPostcode,
        country: companyCountry,
      },
    },
  });
});

router.delete("/logout", async function (req, res) {
  const { token } = req.headers;
  const { email } = req.body;

  if (!token || !email) {
    res.status(400).send({ status: 0 });
    return;
  }

  const result = await runQuery(
    update("tokens", [["token", "null"]], ["token", `'${token}'`])
  );

  if (!result) {
    console.log("error updating token on logout");
    res.status(500).send();
    return;
  }

  res.send({ data: "yeet" });
});

module.exports = router;
