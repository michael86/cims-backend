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
};

module.exports = utils;
