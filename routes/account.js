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

  const user = await asyncMySQL(createUser(), [
    email,
    sha256(`${process.env.SALT}${password}`),
  ]);

  if (user.affectedRows === 0) {
    console.log("registration user error", user);
    return;
  }

  const { insertId } = user;

  const compRes = await asyncMySQL(createCompany(), [
    company,
    companyStreet,
    companyCity,
    companyCounty,
    companyPostcode,
    companyCountry,
  ]);

  if (compRes.affectedRows === 0) {
    console.log("registration company error", user);
    return;
  }

  const connection = await asyncMySQL(connectUserCompany(), [
    user.insertId,
    compRes.insertId,
  ]);

  if (connection.affectedRows === 0) {
    console.log("registration company connection error", company);
  }

  res.send({ code: 1 });
});

module.exports = router;
