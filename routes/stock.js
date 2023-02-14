const { Router } = require("express");
const express = require("express");
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
    for (const location of locations) {
      const { name, value } = location;
      let valid = true;
      if (!name || !value) {
        valid = false;
        break;
      }

      if (name.match(specialCharReg) || value.match(specialCharReg)) {
        console.log("matched");
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

  let valid = true;

  if (!validateLocations(locations)) {
    res.status(400).send({ status: 0, token });
    return;
  }

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

router.post("/add", function (req, res) {
  const { newToken: token } = req.headers;
  const { data } = req.body;

  if (!validateData(data)) {
    res.status(400).send({ status: 0, token });
    return;
  }

  console.log("stock add");
  res.send({ status: 1, token });
});

module.exports = router;
