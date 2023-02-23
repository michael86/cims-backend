const express = require("express");
const { select, insert, update, patchItem } = require("../mysql/query");
const { runQuery } = require("../utils/sql");
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
    dateCreated,
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
    !dateCreated ||
    !locations ||
    !history
  )
    return false;

  if (!validateLocations(locations)) return false;

  let valid = true;

  for (const his of history) {
    const { date, qty, price, locations } = his;
    if (!date || !qty || !price || !locations) {
      valid = false;
      break;
    }

    if (
      typeof date !== "number" ||
      isNaN(Number(qty)) ||
      isNaN(Number(price))
    ) {
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

const getCompanyId = async (data) => {
  const company = {
    name: data.company,
    postcode: data.companyPostcode,
  };

  const [compRes] = await runQuery(
    select("companies", ["id"], ["name", "postcode"]),
    [company.name, company.postcode]
  );

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
      insert("companies", [
        "name",
        "address",
        "city",
        "county",
        "postcode",
        "country",
      ]),
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
    const { insertId: locId } = await runQuery(
      insert("locations", ["name", "value"]),
      [location.name, location.value]
    );

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

  const { insertId: relation } = await runQuery(
    insert("user_stock", ["user_id", "stock_id"]),
    [userId, itemId]
  );

  if (!relation) return;
  return itemId;
};

const addHistoryToItem = async ([data], itemId) => {
  const date = Math.floor(Date.now() / 1000);

  const { insertId: historyId } = await runQuery(
    insert("history", ["date", "quantity", "price"]),
    [date, data.qty, poundsToPennies(data.price)]
  );

  if (!historyId) return;

  const { insertId: histRelation } = await runQuery(
    insert("stock_histories", ["stock_id", "history_id"]),
    [itemId, historyId]
  );

  if (!histRelation) return;

  for (const location of data.locations) {
    const { insertId: locId } = await runQuery(
      insert("locations", ["name", "value"]),
      [location.name, location.value]
    );

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

  const [{ id: userId }] = await runQuery(select("users", ["id"], "email"), [
    email,
  ]);

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

  const compRel = await addCompanytoItem(
    data,
    itemId,
    await getCompanyId(data)
  );
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
  const locIds = await runQuery(
    select("stock_locations", ["location_id AS id"], "stock_id"),
    [id]
  );

  for (const location of locIds) {
    const currentLoc = await runQuery(
      select("locations", ["name", "value"], "id"),
      [location.id]
    );

    for (const index of currentLoc) {
      locations.push({ ...index, id: location.id });
    }
  }

  return locations;
};

const getHistory = async (id) => {
  const history = [];
  const historyIds = await runQuery(
    select("stock_histories", ["history_id AS id"], "stock_id"),
    [id]
  );

  for (const hisId of historyIds) {
    const { id } = hisId;
    const [history] = await runQuery(
      select("history", ["date", "quantity", "price"], "id"),
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

      const [currentLoc] = await runQuery(
        select("locations", ["name", "value"], "id"),
        [id]
      );
      entry.location.push({ ...currentLoc });
    }

    history.push(entry);
  }

  return history;
};
//update to take in a query param called history (bool), this can then be used to decide if we should return with histort
router.get("/get", async function (req, res) {
  const { newToken: token, email } = req.headers;
  const { history, locations } = req.query;

  if (!email) {
    res.end();
    return;
  }

  const [{ id: user }] = await runQuery(select("users", ["id"], "email"), [
    email,
  ]);

  if (!user) {
    res.end();
    return;
  }

  const stockIds = await runQuery(
    select("user_stock", ["stock_id AS stockId"], "user_id"),
    [user]
  );

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
  const { newToken: token, email } = req.headers;
  const { data, history } = req.body;
  const { locations: updateLocations } = req.query;

  const updateLocation = (locations) => {
    console.log(locations);
  };

  const updateItem = await runQuery(
    patchItem(["sku", "quantity", "price", "image_name", "free_issue"], ["id"]),
    [data.sku, data.qty, poundsToPennies(data.price), "null", 0, data.id]
  );

  if (!updateItem.affectedRows) {
    res.status(500).send({ status: 0, token });
  }

  updateLocations && updateLocation(data.location);

  res.send({ status: 1, token });
});
module.exports = router;
