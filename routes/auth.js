const express = require("express");

const router = express.Router();

//If user makes it here, they passed the authe middleware

router.get("/", async function (req, res) {
  res.send({ status: 1 });
});

module.exports = router;
