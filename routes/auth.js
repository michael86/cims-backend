const express = require("express");

const { updateToken } = require("../mysql/query");

const router = express.Router();

//If user makes it here, they passed the authe middleware

router.get("/", async function (req, res) {
  console.log("passed", req.headers);
  try {
  } catch (err) {
    console.error(err);
    res.status({ status: 500 });
    res.send({ status: 500 });
  }

  res.send({ status: 1, token: req.headers.newToken });
});

module.exports = router;
