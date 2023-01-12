const express = require("express");
const router = express.Router();
const sha256 = require("sha256");
const { addToken } = require("../middleware/tokens");
const asyncMySQL = require("../mysql/connection");
const { getUserCreds } = require("../mysql/query");
const { genToken } = require("../utils");

router.put("/", async function (req, res) {
  const { email, password } = req.body;

  if (!email || !password) {
    res.send({ status: 1, error: "credentials not sent" });
    return;
  }

  try {
    const result = await asyncMySQL(getUserCreds("password", "email"), [email]);

    const shaPass = sha256(`${process.env.SALT}${password}`);
    if (!result[0] || shaPass !== result[0].password) {
      //Add some sort of check here to catch brute force
      res.send({ status: 2 });
      return;
    }

    const token = genToken();
    addToken(email, token);

    res.send({ status: 1, token });
  } catch (error) {
    console.log(error);
    res.send({ status: -1, error: "Login failed" });
  }

  res.send();
});

module.exports = router;
