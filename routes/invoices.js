const express = require("express");
const { update, insert } = require("../mysql/query");
const { updateToken, runQuery } = require("../utils/sql");
const router = express.Router();

router.put("/add", async function (req, res) {
  const { newToken: token, tokenId, userId } = req.headers;
  const { items, company, specifics } = req.body;

  if (!items || !company || !specifics) {
    res.status(400).send({ status: 0, token });
    return;
  }

  const { insertId: companyInsertId } = await runQuery(
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

  if (!companyInsertId) {
    res.status(500).send({ status: 0, token });
    return;
  }

  const { insertId: specificsInsertId } = await runQuery(
    insert("invoice_specifics", [
      "billing_date",
      "due_date",
      "order_number",
      "footer",
    ]),
    Object.values(specifics)
  );

  if (!specificsInsertId) {
    res.status(500).send({ status: 0, token });
  }

  // const { insertId: specificsInsertId } = await runQuery(
  //   insert("invoice_specifics", [
  //     "billing_date",
  //     "due_date",
  //     "order_number",
  //     "footer",
  //   ]),
  //   Object.values(specifics)
  // );

  const update = await updateToken(
    "tokens",
    [["token", `'${token}'`]],
    ["id", tokenId]
  );

  res.send({ status: 1, token });
});

module.exports = router;
