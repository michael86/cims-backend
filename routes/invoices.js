const express = require("express");
const router = express.Router();
const path = require("node:path");

const niceInvoice = require("nice-invoice");
const {
  select,
  selectInvoiceCompSpecs,
  selectInvoiceItemIds,
  selectUserInvoiceIds,
} = require("../mysql/query");

const { updateToken, runQuery } = require("../utils/sql");
const _invoices = require("../utils/invoices");
const company = require("../utils/company");

router.put("/add", async function (req, res) {
  const { newToken: token, tokenId, userId } = req.headers;
  const { items, company: comp, specifics } = req.body;

  if (!items || !company || !specifics) {
    res.status(400).send({ status: 0, token });
    return;
  }

  try {
    const companyId = await _invoices.insertCompany(comp);
    if (!companyId || typeof companyId !== "number") throw new Error(companyId);

    const relation = await _invoices.createUserRelation(userId, companyId);
    if (!relation || typeof relation !== "number") throw new Error(companyId);

    const specificsId = await _invoices.createSpecifics(specifics, res);
    if (!specificsId || typeof specificsId !== "number") throw new Error(companyId);

    const specificsRelation = await _invoices.createSpecificRelation(companyId, specificsId);
    if (typeof specificsRelation !== "number") throw new Error(specificsRelation);

    const itemIds = await _invoices.createItems(items);

    if (!Array.isArray(itemIds))
      throw new Error(`invoices/add
    Error creating itemIds
    itemIds: ${itemIds}`);

    const itemRelations = await _invoices.createItemRelations(itemIds, companyId);
    if (!Array.isArray(itemRelations))
      throw new Error(`invoices/add
    Error creating item relations
    result: ${itemRelations}`);

    await updateToken("tokens", [["token", `'${token}'`]], ["id", tokenId]);

    res.send({ status: 1, token });
  } catch (err) {
    console.log(`invoices/add
      \x1b[31m${err}\x1b[0m`);
    res.send({ status: 0, token });
  }
});

router.get("/get/:id?", async function (req, res) {
  const { newToken: token, userId } = req.headers;
  const { id } = req.query;

  try {
    const ids = id ? [id] : await _invoices.getInvoiceIds(userId);

    if (!Array.isArray(ids)) throw new Error(ids);

    const invoices = await _invoices.getInvoices(ids);
    if (!Array.isArray(invoices)) throw new Error(invoices);

    // console.log(invoices);
    res.send({ status: 1, token, invoices });
  } catch (err) {
    console.log(`invoices/get
      \x1b[31m${err}\x1b[0m`);
    res.status(500).send({ status: 0, token });
  }
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

  for (const i of itemsData) {
    const [itemData] = await runQuery(
      select("invoice_items", ["sku", "description", "quantity", "price", "tax"], "id"),
      [i.item_id]
    );

    items.push({
      item: itemData.sku,
      description: itemData.description,
      quantity: itemData.quantity,
      price: itemData.price,
      tax: itemData,
    });
  }

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

  const fileName = `${invoiceData.contact.replace(" ", "")}-${invoiceData.name}.pdf`;

  const filePath = path.join(__dirname, "..", "public/_invoices", fileName);

  niceInvoice(invoiceDetail, filePath);

  res.send({ status: 1, token, fileName });
});

module.exports = router;
