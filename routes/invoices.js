const express = require("express");
const niceInvoice = require("nice-invoice");
const {
  select,
  insert,
  selectInvoiceCompSpecs,
  selectInvoiceItemIds,
  selectUserInvoiceIds,
} = require("../mysql/query");
const { updateToken, runQuery } = require("../utils/sql");
const router = express.Router();
const fs = require("fs");
const path = require("node:path");

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

  specifics.dueDate = Math.floor(new Date(specifics.dueDate).getTime() / 1000);
  specifics.billingDate = Math.floor(
    new Date(specifics.billingDate).getTime() / 1000
  );

  console.log(specifics);
  const { insertId: specificsInsertId } = await runQuery(
    insert("invoice_specifics", [
      "due_date",
      "billing_date",
      "order_number",
      "footer",
    ]),
    [
      specifics.dueDate,
      specifics.billingDate,
      specifics.orderNumber,
      specifics.footer,
    ]
  );

  if (!specificsInsertId) {
    res.status(500).send({ status: 0, token });
    return;
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
      [item.name, item.description, item.quantity, item.price, item.tax]
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

  const invoices = await runQuery(selectUserInvoiceIds(userId));

  //Run checks to see what happens when user has no invoices. Is it undefined or empty array?
  if (!invoices) {
    res.send({ status: 1, token });
    return;
  }

  const data = [];

  for (const id of invoices) {
    const [companySpecifics] = await runQuery(selectInvoiceCompSpecs(), [
      id.invoice_id,
      id.invoice_id,
    ]);

    if (!companySpecifics) continue; //Something broke cause my code is broke and everything just feels broken!!

    const invoice = {
      id: id.invoice_id,
      contact: companySpecifics.contact,
      name: companySpecifics.name,
      address: companySpecifics.address,
      city: companySpecifics.city,
      state: companySpecifics.state,
      country: companySpecifics.country,
      postcode: companySpecifics.postcode,
      billingDate: companySpecifics.billing_date, // need to convert to unix in sql
      dueDate: companySpecifics.due_date, //need to convert to unix in sql
      order_number: companySpecifics.order_number,
      footer: companySpecifics.footer,
      items: [],
    };

    const items = await runQuery(selectInvoiceItemIds(), [id.invoice_id]);

    for (const item of items) {
      const itemData = await runQuery(
        select(
          "invoice_items",
          ["sku", "description", "quantity", "price", "tax"],
          "id"
        ),

        [item.item_id]
      );

      invoice.items.push({ ...itemData[0] });
    }

    data.push(invoice);
  }

  res.send({ status: 1, token, data });
});

router.post("/gen-pdf", async function (req, res) {
  const { newToken: token } = req.headers;
  let { id, company } = req.body;

  if (isNaN(Number(id))) {
    res.status(400).send({ status: 0, token });
    return;
  }

  const [invoiceData] = await runQuery(selectInvoiceCompSpecs(), [id, id]);

  const itemsData = await runQuery(selectInvoiceItemIds(), [id]);

  const items = [];
  console.log("start items");
  for (const i of itemsData) {
    const [itemData] = await runQuery(
      select(
        "invoice_items",
        ["sku", "description", "quantity", "price", "tax"],
        "id"
      ),
      [i.item_id]
    );

    console.log(itemData.sku);
    items.push({
      item: itemData.sku,
      description: itemData.description,
      quantity: itemData.quantity,
      price: itemData.price,
      tax: itemData,
    });
    console.log("item done");
  }

  console.log(items);
  const invoiceDetail = {
    shipping: {
      name: `${invoiceData.contact} - ${invoiceData.name}`,
      address: invoiceData.address,
      city: invoiceData.city,
      state: invoiceData.state,
      country: invoiceData.country,
      postal_code: invoiceData.postcode,
    },
    items,
    total: 2,
    order_number: invoiceData.order_number,
    header: {
      company_name: company.name,
      company_logo: "logo.png",
      company_address: `${company.address}, ${company.city}, ${company.county}, ${company.postcode}, ${company.country}`,
    },
    footer: {
      text: invoiceData.footer,
    },
    currency_symbol: "£",
    date: {
      billing_date: invoiceData.billing_date,
      due_date: invoiceData.due_date,
    },
  };

  const fileName = `${invoiceData.contact.replace(" ", "")}-${
    invoiceData.name
  }.pdf`;

  const filePath = path.join(__dirname, "..", "public/invoices", fileName);

  niceInvoice(invoiceDetail, filePath);

  res.send({ status: 1, token, fileName });
});

module.exports = router;
