const express = require("express");
const router = express.Router();
const sha256 = require("sha256");

router.get("/", function (req, res) {
  const {
    email,
    password,
    companyName,
    companyStreet,
    companyCity,
    companyCounty,
    companyPostcode,
    companyCountry,
  } = req.body;

  if (
    !email ||
    !password ||
    !companyName ||
    !companyStreet ||
    !companyCity ||
    !companyCounty ||
    !companyPostcode ||
    !companyCountry
  ) {
    res.send({ status: 0, error: "Invalid registration" });
  }

  connection.query(
    `INSERT INTO users (email, password) VALUES ("${email}", "${sha256(
      password
    )}");`
  );

  res.send({ status: 1 });
});

module.exports = router;
