const { runQuery } = require("../sql");
const queries = require("../../mysql/query");
const generic = require("../../utils/generic");

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

    let valid = true;
    for (const his of history) {
      const { qty, locations } = his;
      if (!qty || !locations) {
        valid = false;
        break;
      }
    }

    return valid;
  },

  createStock: async ({ sku, qty, price }) => {
    try {
      const res = await runQuery(queries.stock.insertStock(), [
        sku,
        qty,
        price ? generic.poundsToPennies(price) : 0,
        null,
        !price ? 1 : 0,
      ]);

      if (res instanceof Error) return res;

      return res.insertId;
    } catch (err) {
      return `createStock: ${err}`;
    }
  },

  addItemToUser: async (data, id) => {
    try {
      const { sku, qty, price } = data;

      const valid = await utils.validateUserSku(sku, id);
      if (valid instanceof Error) throw new Error(valid);

      if (!valid) return "used";

      const itemId = await utils.createStock({ sku, qty, price });
      if (itemId instanceof Error) throw new Error(itemId);

      const relation = await runQuery(queries.user.insertRelation("stock", "stock_id"), [
        id,
        itemId,
      ]);

      if (relation instanceof Error) throw new Error(relation);

      return itemId;
    } catch (err) {
      return `addItemToUser: ${err}`;
    }
  },

  validateUserSku: async (sku, id) => {
    try {
      const skus = await runQuery(queries.stock.selectUserSkus(), [id]);

      if (skus instanceof Error) throw new Error(skus);

      return skus.every((i) => i.sku !== sku);
    } catch (err) {
      return `validateUserSku: ${err}`;
    }
  },
};

module.exports = utils;
