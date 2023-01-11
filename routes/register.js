const express = require("express");
const router = express.Router();
const sha256 = require("sha256");
const asyncMySQL = require("../mysql/connection");
const { createUser } = require("../mysql/query");

router.put("/", async function (req, res) {
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

  try {
    const result = await asyncMySQL(createUser(), [email, sha256(password)]);
    if (result.affectedRows > 0) {
      res.send({ code: 1 });
    }
  } catch (error) {
    console.log(error);
    if (error.code === "ER_DUP_ENTRY") {
      res.send({ code: 2 });
      return;
    }
  }
});

module.exports = router;
