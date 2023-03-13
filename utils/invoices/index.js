const queries = require("../../mysql/query");
const { runQuery } = require("../sql");

const utils = {
  createInvoiceSpecifics: async (specifics) => {
    try {
      specifics.dueDate = Math.floor(new Date(specifics.dueDate).getTime() / 1000);
      specifics.billingDate = Math.floor(new Date(specifics.billingDate).getTime() / 1000);

      const result = await runQuery(queries.insertInvoiceSpecifics(), [
        specifics.dueDate,
        specifics.billingDate,
        specifics.orderNumber,
        specifics.footer,
      ]);

      if (!result.affectedRows) throw new Error(`Error inserting specifics \n result: ${result}`);

      return result.insertId;
    } catch (err) {
      console.log(`${err}\n
      specifics: ${specifics}`);
      return;
    }
  },
};

module.exports = utils;
