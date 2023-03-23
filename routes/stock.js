const express = require("express");
const {
  insert,
  remove,
  insertHistory,
  createHistoryRelation,
  createHistoryLocRelation,
} = require("../mysql/query");
const { runQuery } = require("../utils/sql");
const { getLocationsToDelete, getLocationsToInsert } = require("../utils");
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

    const locs = await stock.createLocations(locations, itemId);
    if (locs instanceof Error) throw new Error(locations);

    const his = await stock.createHistory(history, itemId);
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
    const updateLocations = async (newLocs, oldLocs) => {
      const locationsToDelete = getLocationsToDelete(newLocs, oldLocs);
      const locationsToInsert = getLocationsToInsert(newLocs, oldLocs);

      for (const id of locationsToDelete) {
        const res = await runQuery(remove("stock_locations", "location_id"), [id]);

        if (!res.affectedRows) return false;
      }

      for (const location of locationsToInsert) {
        const { insertId } = await runQuery(insert("locations", ["name", "value"]), [
          location.name,
          location.value,
        ]);

        if (!insertId) return false;

        const { insertId: relationId } = await runQuery(
          insert("stock_locations", ["stock_id", "location_id"]),
          [data.id, insertId]
        );

        if (!relationId) return false;
      }

      return true;
    };

    const createHistory = async (history) => {
      const historyRes = await runQuery(insertHistory(), [
        history.sku,
        history.quantity,
        history.price,
      ]);

      const relationRes = await runQuery(createHistoryRelation(), [
        history.id,
        historyRes.insertId,
      ]);

      for (const location of history.locations) {
        const locRes = await runQuery(createHistoryLocRelation(), [
          historyRes.insertId,
          location.id,
        ]);
      }
    };

    const patched = await stock.patchItem(userId, data, history, locations);
    if (patched instanceof Error) throw new Error(patched);
    if (!patched) {
      res.send({ status: 3, token });
      return;
    }

    if (+updateLocs) {
      const locRes = await updateLocations(data.locations, history.locations);

      if (!locRes) {
        res.status(500).send({ status: 0, error: "failed to updated locations." });

        return;
      }
    }

    createHistory(history);
    res.send({ status: 1, token });
  } catch (err) {
    console.log(`stock/update
      \x1b[31m${err}\x1b[0m`);
    res.status(500).send({ status: 0, token });
  }
});

router.delete("/delete", async function (req, res) {
  const { newToken: token } = req.headers;

  console.log("delete");

  res.send({ status: 1, token });
});
module.exports = router;
