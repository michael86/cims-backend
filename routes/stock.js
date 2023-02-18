const express = require("express");
const { select, insert } = require("../mysql/query");
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

module.exports = router;
