const express = require("express");
const { updateToken } = require("../utils/sql");
const router = express.Router();

//If user makes it here, they passed the auth middleware
router.get("/", async function (req, res) {
  const { newToken: token, tokenId } = req.headers;

  const update = await updateToken(
    "tokens",
    [["token", `'${token}'`]],
    ["id", tokenId]
  );

  update ? res.send({ status: 1, token }) : res.status(500).send({ status: 0 });
});

module.exports = router;
