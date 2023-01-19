const express = require("express");
const { update } = require("../mysql/query");
const { updateToken } = require("../utils/sql");
const router = express.Router();

router.put("/add", async function (req, res) {
  const { newToken: token, tokenId } = req.headers;

  console.log("req.body", req.body);

  const update = await updateToken(
    "tokens",
    [["token", `'${token}'`]],
    ["id", tokenId]
  );

  console.log("udpate", update);

  res.send({ status: 1, token });
});

module.exports = router;
