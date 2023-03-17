const { runQuery } = require("../sql");
const queries = require("../../mysql/query");

const utils = {
  createStock: async (items) => {
    try {
      const ids = [];
      for (const item of items) {
        const res = await runQuery(queries.insertInvoiceItems(), [
          item.name,
          item.description,
          item.quantity,
          item.price,
          item.tax,
        ]);

        if (!res.insertId) throw new Error(`Error getting res \n res: ${res}`);

        ids.push(res.insertId);
      }

      return ids;
    } catch (err) {
      console.log(`Error in stock utils\n
      ${err}\n
      items: ${items}`);
      return;
    }
  },

  validateData: (payload) => {
    //Don't check for price as can be ommitted if free issue

    const {
      sku,
      qty,
      company,
      companyStreet,
      companyCity,
      companyCounty,
      companyCountry,
      companyPostcode,
      locations,
      history,
    } = payload;

    if (
      !sku ||
      !qty ||
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

    if (!utils.validateLocations(locations)) return false;
    let valid = true;

    for (const his of history) {
      const { qty, locations } = his;
      if (!qty || !locations) {
        valid = false;
        break;
      }

      if (!utils.validateLocations(locations)) {
        valid = false;
        break;
      }
    }

    return valid;
  },

  validateLocations: (locations) => {
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
  },

  createStock: async (item) => {
    try {
      const res = await runQuery(
        insert("stock", ["sku", "quantity", "price", "image_name", "free_issue"]),
        [sku, qty, poundsToPennies(price), "null", false]
      );
      console.log(res);
      if (res instanceof Error) return;
    } catch (err) {
      return err;
    }
  },

  addItemToUser: async (data, id) => {
    try {
      console.log(data);
      const { sku, qty, price } = data;

      return itemId;
    } catch (err) {
      return err;
    }
  },
};

module.exports = utils;
