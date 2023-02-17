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
    const specialCharReg = /[ `!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?~]/;
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

const isSkuUsed = async (userId, sku) => {
  const [stockIds] = await runQuery(
    select("user_stock", ["stock_id"], "user_id"),
    [userId]
  );

  //if the user doesn't have any stock relationships
  //return true as no need to validate sku hasn't been used
  if (!stockIds) return true;

  return true;
};

const poundsToPennies = (amount) => Math.floor(parseFloat(amount) * 100);

const addCompanyToItem = async (data) => {
  const company = {
    company: data.company,
    companyStreet: data.companyStreet,
    companyCity: data.companyCity,
    companyCounty: data.companyCounty,
    companyCountry: data.companyCountry,
    companyPostcode: data.companyPostcode,
  };

  console.log(select("companies", ["id"], ["name", "postcode"]));

  const doesCompanyExists = await runQuery(
    select("companies", ["id"], ["name", "postcode"]),
    [company, companyPostcode]
  );
};

const addItemToUser = async (data) => {
  const { sku, qty, price, locations, history } = data;

  const { insertId: itemId } = await runQuery(
    insert("stock", ["sku", "quantity", "price", "image_name", "free_issue"]),
    [sku, qty, poundsToPennies(price), "null", false]
  );

  if (!itemId) {
    res.status(500).send({ status: 0, token });
    return;
  }

  const companyId = addCompanyToItem(data);
};

router.post("/add", async function (req, res) {
  const { newToken: token, email } = req.headers;
  const { data } = req.body;

  if (!validateData(data) || !email) {
    res.status(400).send({ status: 0, token });
    return;
  }

  const { sku } = data;

  const [{ id: userId }] = await runQuery(select("users", ["id"], "email"), [
    email,
  ]);

  if (!userId) {
    res.status(400).send({ status: 1, token });
    return;
  }

  if (!(await isSkuUsed(userId, sku))) {
    res.send({ status: 2, token });
    return;
  }

  const added = await addItemToUser(data);
  res.send({ status: 1, token });
});

module.exports = router;
