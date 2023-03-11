const { runQuery } = require("../sql");
const queries = require("../../mysql/query");

const utils = {
  createStock: async (items) => {
    try {
      const ids = [];
      for (const item of items) {
        const { insertId: itemId } = await runQuery(queries.insertInvoiceStock(), [
          item.name,
          item.description,
          item.quantity,
          item.price,
          item.tax,
        ]);

        if (!itemId) throw new Error(`Error inserting stock \n item: ${item}`);

        itemIds.push(itemId);
      }

      return ids;
    } catch (err) {
      console.log(err);
      return;
    }
  },
};

module.exports = utils;
