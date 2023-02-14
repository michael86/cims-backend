const express = require("express");

const router = express.Router();

router.get("/", async function (req, res) {
  const { newToken: token, email } = req.headers;
  res.send({ status: 1, token, email });
});

module.exports = router;
