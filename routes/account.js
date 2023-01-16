const express = require("express");
const asyncMySQL = require("../mysql/connection");
const {
  getUserCreds,
  insertUserToken,
  insertUserTokenConnection,
  createUser,
  createCompany,
  connectUserCompany,
} = require("../mysql/query");

const router = express.Router();
const sha256 = require("sha256");
const { addToken } = require("../middleware/tokens");
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

    const tokenInsert = await asyncMySQL(insertUserToken(), [token]);

    const connectRes = await asyncMySQL(insertUserTokenConnection(), [
      user[0].id,
      tokenInsert.insertId,
    ]);

    addToken(email, {
      userId: user[0].id,
      token,
      tokenId: tokenInsert.insertId,
      connection: connectRes.insertId,
    });

    res.send({
      status: 1,
      token,
      email,
      // data: {
      //   token,
      //    id,
      //    email,
      //    company,
      //    address,
      //    city,
      //    county,
      //    postcode,
      //    country,
      // },
    });
  } catch (error) {
    console.log(error);
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

  console.log("res.send(");

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

module.exports = router;
