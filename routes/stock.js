const express = require("express");
const {
  select,
  insert,
  patchItem,
  remove,
  insertHistory,
  createHistoryRelation,
  createHistoryLocRelation,
} = require("../mysql/query");
const { runQuery } = require("../utils/sql");
const { getLocationsToDelete, getLocationsToInsert } = require("../utils");
const router = express.Router();

const validateData = (payload) => {
  const {
    sku,
    qty,
    price,
    company,
    companyStreet,
    companyCity,
    companyCounty,
    companyCountry,
    companyPostcode,
    locations,
    history,
  } = payload;

  const validateLocations = (locations) => {
    const specialCharReg = /[`!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?~]/;
    let valid = true;
    for (const location of locations) {
      const { name, value } = location;
      if (!name || !value) {
        valid = false;
        break;
      }

      if (name.match(specialCharReg) || value.match(specialCharReg)) {
        valid = false;
        break;
      }
    }

    return valid;
  };

  if (
    !sku ||
    !qty ||
    !price ||
    !company ||
    !companyStreet ||
    !companyCity ||
    !companyCounty ||
    !companyCountry ||
    !companyPostcode ||
    !locations ||
    !history
  )
    return false;

  if (!validateLocations(locations)) return false;

  let valid = true;

  for (const his of history) {
    const { qty, price, locations } = his;
    if (!qty || !price || !locations) {
      valid = false;
      break;
    }

    if (!validateLocations(locations)) {
      valid = false;
      break;
    }
  }

  return valid;
};

const poundsToPennies = (amount) => Math.floor(parseFloat(amount) * 100);
const penniesToPounds = (amount) => Math.floor(parseFloat(amount) / 100);

const getCompanyId = async (data) => {
  const company = {
    name: data.company,
    postcode: data.companyPostcode,
  };

  const [compRes] = await runQuery(select("companies", ["id"], ["name", "postcode"]), [
    company.name,
    company.postcode,
  ]);

  return compRes?.id || undefined;
};

const addCompanytoItem = async (data, itemId, companyId) => {
  const company = Object.values({
    company: data.company,
    companyStreet: data.companyStreet,
    companyCity: data.companyCity,
    companyCounty: data.companyCounty,
    companyPostcode: data.companyPostcode,
    companyCountry: data.companyCountry,
  });

  //something is missing... If legal request was made, this will always be 6, so just stop here.
  if (!companyId) {
    const { insertId: id } = await runQuery(
      insert("companies", ["name", "address", "city", "county", "postcode", "country"]),
      [...company]
    );

    if (!id) return;

    companyId = id;
  }

  const { insertId: relationship } = await runQuery(
    insert("stock_company", ["stock_id", "company_id"]),
    [itemId, companyId]
  );

  if (!relationship) return;

  return true;
};

const addLocationstoItem = async (locations, itemId) => {
  for (const location of locations) {
    const { insertId: locId } = await runQuery(insert("locations", ["name", "value"]), [
      location.name,
      location.value,
    ]);

    if (!locId) return;

    const { insertId: relationship } = await runQuery(
      insert("stock_locations", ["stock_id", "location_id"]),
      [itemId, locId]
    );

    if (!relationship) return;
  }
  return true;
};

const addItemToUser = async (data, userId) => {
  const { sku, qty, price } = data;

  const itemRes = await runQuery(
    insert("stock", ["sku", "quantity", "price", "image_name", "free_issue"]),
    [sku, qty, poundsToPennies(price), "null", false]
  );

  if (!itemRes) return;
  if (itemRes === "ER_DUP_ENTRY") return itemRes;

  const { insertId: itemId } = itemRes;

  const { insertId: relation } = await runQuery(insert("user_stock", ["user_id", "stock_id"]), [
    userId,
    itemId,
  ]);

  if (!relation) return;
  return itemId;
};

const addHistoryToItem = async ([data], itemId) => {
  const { insertId: historyId } = await runQuery(insert("history", ["quantity", "price"]), [
    data.qty,
    poundsToPennies(data.price),
  ]);

  if (!historyId) return;

  const { insertId: histRelation } = await runQuery(
    insert("stock_histories", ["stock_id", "history_id"]),
    [itemId, historyId]
  );

  if (!histRelation) return;

  for (const location of data.locations) {
    const { insertId: locId } = await runQuery(insert("locations", ["name", "value"]), [
      location.name,
      location.value,
    ]);

    if (!locId) return;

    const { insertId: relationship } = await runQuery(
      insert("history_locations", ["history_id", "location_id"]),
      [historyId, locId]
    );

    if (!relationship) return;
  }
  return true;
};

//Any where there's a res.end is because the user may be up to no good.
//Prob refactor that to be middleware when we add validation
router.post("/add", async function (req, res) {
  const { newToken: token, email } = req.headers;
  const { data } = req.body;
  const { locations, history } = data;

  if (!validateData(data) || !email) return;

  const [{ id: userId }] = await runQuery(select("users", ["id"], "email"), [email]);

  if (!userId) return;

  const itemId = await addItemToUser(data, userId);

  if (!itemId) {
    res.end();
    return;
  }
  if (itemId === "ER_DUP_ENTRY") {
    res.send({ status: 2, token });
    return;
  }

  const compRel = await addCompanytoItem(data, itemId, await getCompanyId(data));
  if (!compRel) {
    res.end();
    return;
  }

  const locationRel = await addLocationstoItem(locations, itemId);
  if (!locationRel) {
    res.end();
    return;
  }

  const historyRel = await addHistoryToItem(history, itemId);
  if (!historyRel) {
    res.end();
    return;
  }

  res.send({ status: 1, token });
});

const getLocations = async (id) => {
  const locations = [];
  const locIds = await runQuery(select("stock_locations", ["location_id AS id"], "stock_id"), [id]);

  for (const location of locIds) {
    const currentLoc = await runQuery(select("locations", ["name", "value"], "id"), [location.id]);

    for (const index of currentLoc) {
      locations.push({ ...index, id: location.id });
    }
  }

  return locations;
};

const getHistory = async (id) => {
  const history = [];
  const historyIds = await runQuery(select("stock_histories", ["history_id AS id"], "stock_id"), [
    id,
  ]);

  for (const hisId of historyIds) {
    const { id } = hisId;
    const [history] = await runQuery(
      select("history", ["quantity", "price", "UNIX_TIMESTAMP(date_added) AS dateAdded"], "id"),
      [id]
    );

    const entry = { ...history };
    entry.location = [];

    const hisLocId = await runQuery(
      select("history_locations", ["location_id AS id"], "history_id"),
      [id]
    );

    for (const index of hisLocId) {
      const { id } = index;

      const [currentLoc] = await runQuery(select("locations", ["name", "value"], "id"), [id]);
      entry.location.push({ ...currentLoc });
    }

    history.push(entry);
  }

  return history;
};

router.get("/get", async function (req, res) {
  const { newToken: token, email } = req.headers;
  const { history, locations } = req.query;

  if (!email) {
    res.end();
    return;
  }

  const [{ id: user }] = await runQuery(select("users", ["id"], "email"), [email]);

  if (!user) {
    res.end();
    return;
  }

  const stockIds = await runQuery(select("user_stock", ["stock_id AS stockId"], "user_id"), [user]);

  //handle if user has no stock
  if (!stockIds) {
    res.send({ status: 1, stock: [] });
    return;
  }

  const stock = [];
  try {
    for (const index of stockIds) {
      const { stockId: id } = index;

      const [itemDetails] = await runQuery(
        select(
          "stock",
          [
            "sku",
            "quantity",
            "price",
            "free_issue AS freeIssue",
            "UNIX_TIMESTAMP(date) AS dateCreated",
          ],
          "id"
        ),
        [id]
      );

      const item = { ...itemDetails };
      item.id = id;

      //gen additional data if in query params
      locations
        ? (item.locations = await getLocations(id))
        : history
        ? (item.history = await getHistory(id))
        : null;

      stock.push(item);
    }
  } catch (e) {
    console.log(e);
  }

  res.send({ status: 1, token, stock });
});

router.patch("/update", async function (req, res) {
  const { newToken: token } = req.headers;
  const { data, history } = req.body;
  const { locations: updateLocs } = req.query;

  const updateLocations = async (newLocs, oldLocs) => {
    const locationsToDelete = getLocationsToDelete(newLocs, oldLocs);
    const locationsToInsert = getLocationsToInsert(newLocs, oldLocs);

    //Delete current locations
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
    //insert sku, quantity, price into history

    const historyRes = await runQuery(insertHistory(), [
      history.sku,
      history.quantity,
      history.price,
    ]);

    //create relation to stock_histories
    const relationRes = await runQuery(createHistoryRelation(), [history.id, historyRes.insertId]);

    //create relations between history_locations
    for (const location of history.locations) {
      const locRes = await runQuery(createHistoryLocRelation(), [historyRes.insertId, location.id]);
    }
  };

  const updateItem = await runQuery(
    patchItem(["sku", "quantity", "price", "image_name", "free_issue"], ["id"]),
    [data.sku, data.qty, poundsToPennies(data.price), "null", 0, data.id]
  );

  if (updateItem === "ER_DUP_ENTRY") {
    res.send({ status: 3, token });
    return;
  }

  if (!updateItem.affectedRows) {
    res.status(500).send({ status: 0, token });
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
});

router.delete("/delete", async function (req, res) {
  const { newToken: token } = req.headers;

  console.log("delete");

  res.send({ status: 1, token });
});
module.exports = router;
