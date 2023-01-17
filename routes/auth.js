const express = require("express");

const { updateToken, update } = require("../mysql/query");
const { runQuery } = require("../utils/sql");

const router = express.Router();

//If user makes it here, they passed the auth middleware
router.get("/", async function (req, res) {
  const { newToken: token, tokenId } = req.headers;

  try {
    const { affectedRows } = await runQuery(
      update("tokens", [["token", `'${token}'`]], ["id", tokenId])
    );

    if (!affectedRows) {
      res.status(500).send({ status: 0 });
    }
  } catch (err) {
    console.log("auth error", err);
    res.status({ status: 500 }).send({ status: 0 });
  }

  res.send({ status: 1, token });
});

module.exports = router;
