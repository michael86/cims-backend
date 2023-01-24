const express = require("express");
const {
  update,
  insert,
  select,
  selectUserInvoices,
} = require("../mysql/query");
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

  const itemIds = [];
  for (const item of items) {
    const { insertId: itemId } = await runQuery(
      insert("invoice_items", [
        "sku",
        "description",
        "quantity",
        "price",
        "tax",
      ]),
      [item.item, item.description, item.quantity, item.price, item.tax]
    );

    if (!itemId) {
      res.status(500).send({ status: 0, token });
      return;
    }

    itemIds.push(itemId);
  }

  //Begin relationship entries

  const { insertId: userRelationship } = await runQuery(
    insert("user_invoices", ["user_id", "invoice_id"]),
    [userId, companyInsertId]
  );

  if (!userRelationship) {
    res.status(500).send({ status: 0, token });
  }

  const { insertId: specificsRelationship } = await runQuery(
    insert("invoice_specific", ["invoice_id", "specific_id"]),
    [companyInsertId, specificsInsertId]
  );

  if (!specificsRelationship) {
    res.status(500).send({ status: 0, token });
  }

  for (const itemId of itemIds) {
    console.log("itemId", itemId);
    const { insertId: itemInsertId } = await runQuery(
      insert("invoice_item", ["invoice_id", "item_id"]),
      [companyInsertId, itemId]
    );

    if (!itemInsertId) {
      res.status(500).send({ status: 0, token });
    }
  }

  await updateToken("tokens", [["token", `'${token}'`]], ["id", tokenId]);

  res.send({ status: 1, token });
});

router.get("/get", async function (req, res) {
  const { newToken: token, userId } = req.headers;

  const invoices = await runQuery(selectUserInvoices(userId));

  console.log("invoices", invoices);

  console.log("sending new token", token);

  res.send({ status: 1, token });
});

module.exports = router;
