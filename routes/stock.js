const express = require("express");
const router = express.Router();

const stock = require("../utils/stock");
const account = require("../utils/account");
const company = require("../utils/company");

router.post("/add", async function (req, res) {
  const { newToken: token, email } = req.headers;
  const { data } = req.body;
  const { locations, history } = data;

  if (!stock.validateData(data) || !email) {
    res.status(400).send({ status: 0, token });
    return;
  }

  try {
    const { id } = await account.getUserDetails(["id"], ["email", email]);
    if (id instanceof Error) throw new Error(id);

    const itemId = await stock.addItemToUser(data, id);
    if (itemId instanceof Error) throw new Error(itemId);

    if (itemId === "used") {
      res.send({ status: 2, token });
      return;
    }

    const compId = await company.createCompany(data, true);
    if (compId instanceof Error) throw new Error(compId);

    const compRelation = await stock.createCompanyRelation(itemId, compId);
    if (compRelation instanceof Error) throw new Error(compRelation);

    const locs = await stock.createLocations(locations);
    if (locs instanceof Error) throw new Error(locs);

    const locRelation = await stock.createLocationRelations(locs, itemId);
    if (locRelation instanceof Error) throw new Error(locRelation);

    const his = await stock.createHistory(history[0], itemId);
    if (his instanceof Error) throw new Error(his);

    res.send({ status: 1, token });
  } catch (err) {
    console.log(`stock/add
      \x1b[31m${err}\x1b[0m`);
    res.status(500).send({ status: 0, token });
  }
});

router.get("/get", async function (req, res) {
  const { newToken: token, email } = req.headers;
  const { history, locations, id } = req.query;

  if (!email) {
    res.status(400).send({ status: 0 });
    return;
  }

  try {
    let user = await account.getUserDetails(["id"], ["email", email]);
    if (user instanceof Error) throw new Error(user);

    const data = await stock.getStock(user.id, locations, history, id);

    res.send({ status: 1, token, stock: data });
  } catch (err) {
    console.log(`stock/get
      \x1b[31m${err}\x1b[0m`);
    res.status(500).send({ status: 0, token });
  }
});

router.patch("/update", async function (req, res) {
  const { newToken: token, userId } = req.headers;

  const { data, history } = req.body;
  const { locations } = req.query;

  if (!data || !history) {
    res.status(400).send({ status: 0, token });
    return;
  }

  try {
    const patched = await stock.patchItem(userId, data, history, locations);
    if (patched instanceof Error) throw new Error(patched);
    if (!patched) {
      res.send({ status: 3, token });
      return;
    }

    res.send({ status: 1, token });
  } catch (err) {
    console.log(`stock/update
      \x1b[31m${err}\x1b[0m`);
    res.status(500).send({ status: 0, token });
  }
});

router.delete("/delete", async function (req, res) {
  const { newToken: token } = req.headers;
  const { id } = req.query;

  if (!id) {
    res.status(500).send({ status: 0 });
    return;
  }

  try {
    const stockDeleted = await stock.deleteStock(id);
    if (stockDeleted instanceof Error) throw new Error(stockDeleted);

    const historyDeleted = await stock.deleteHistory(id);
    if (historyDeleted instanceof Error) throw new Error(historyDeleted);

    res.send({ status: 1, token });
  } catch (err) {
    res.status(500).send({ status: 0, token });
    console.log(`stock/delete
      \x1b[31m${err}\x1b[0m`);
  }
});
module.exports = router;
