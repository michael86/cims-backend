const express = require("express");
const router = express.Router();

const { updateToken } = require("../utils/sql");
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
    const companyId = await _invoices.createCompany(comp, true);

    if (companyId instanceof Error) throw new Error(companyId);

    const relation = await _invoices.createUserRelation(userId, companyId);
    if (relation instanceof Error) throw new Error(companyId);

    const specificsId = await _invoices.createSpecifics(specifics, res);
    if (specificsId instanceof Error) throw new Error(companyId);

    const specificsRelation = await _invoices.createSpecificRelation(companyId, specificsId);
    if (specificsRelation instanceof Error) throw new Error(specificsRelation);

    const itemIds = await _invoices.createItems(items);

    if (itemIds instanceof Error) throw new Error(itemIds);

    const itemRelations = await _invoices.createItemRelations(itemIds, companyId);
    if (itemRelations instanceof Error) throw new Error(itemRelations);

    await updateToken("tokens", [["token", `'${token}'`]], ["id", tokenId]);

    res.send({ status: 1, token });
  } catch (err) {
    console.log(`invoices/add
      \x1b[31m${err}\x1b[0m`);
    res.send({ status: 0, token });
  }
});

router.get("/get/:id?:download?", async function (req, res) {
  const { newToken: token, userId } = req.headers;
  const { id, download } = req.query;

  try {
    const ids = id ? [id] : await _invoices.getInvoiceIds(userId);
    if (ids instanceof Error) throw new Error(ids);

    const invoices = await _invoices.getInvoices(ids);
    if (invoices instanceof Error) throw new Error(invoices);

    if (download) {
      const filename = await _invoices.createFile(invoices, userId);

      if (filename instanceof Error) throw new Error(filename);

      res.send({ status: 1, token, filename });
      return;
    }

    res.send({ status: 1, token, invoices });
  } catch (err) {
    console.log(`invoices/get
      \x1b[31m${err}\x1b[0m`);
    res.status(500).send({ status: 0, token });
  }
});

module.exports = router;
