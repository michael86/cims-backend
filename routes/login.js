const express = require("express");
const router = express.Router();
const sha256 = require("sha256");

router.get("/", function (req, res) {
  console.log("sasas", req.newToken);
  res.send();
});

module.exports = router;
