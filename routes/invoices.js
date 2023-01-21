const express = require("express");
const { update, insert } = require("../mysql/query");
const { updateToken, runQuery } = require("../utils/sql");
const router = express.Router();

router.put("/add", async function (req, res) {
  const { newToken: token, tokenId, userId } = req.headers;
  const { items, company, specifics } = req.body;

  if (!items || !company || !specifics) {
    res.status(400).send({ status: 0 });
    return;
  }

  const companyRes = await runQuery(
    insert("invoice_company", [
      "contact",
      "name",
      "address",
      "city",
      "state",
      "country",
      "postcode",
    ]),
    Object.values(company)
  );

  console.log("companyRes", companyRes);

  const update = await updateToken(
    "tokens",
    [["token", `'${token}'`]],
    ["id", tokenId]
  );

  res.send({ status: 1, token });
});

module.exports = router;
