const queries = require("../../mysql/query");
const { runQuery } = require("../sql");
const { poundsToPennies } = require("../generic");

const utils = {
  insertCompany: async (data) => {
    /*This is not in the company utils as we have a sep table for companies that an invoice is to.
      At some point, we could add a new column on the companies table called contact and allow it to be Null
      Then insert into there, but for the sake of it though. I'm lazy ;) */
    try {
      const res = await runQuery(queries.invoices.insertCompany(), [
        data.contact,
        data.company,
        data.companyStreet,
        data.companyCity,
        data.companyCounty,
        data.companyCountry,
        data.companyPostcode,
      ]);

      if (!res.insertId) throw new Error(res);
      return res.insertId;
    } catch (err) {
      console.log(`
        invoices.createCompany
        \x1b[31m${err}\x1b[0m\n`);
      return;
    }
  },
  createUserRelation: async (user, invoice) => {
    try {
      const res = await runQuery(queries.invoices.insertUserRelation(), [user, invoice]);

      if (!res.insertId) throw new Error(res);

      return res.insertId;
    } catch (err) {
      console.log(`
        invoices.createUserRelation
        \x1b[31m${err}\x1b[0m\n`);
      return;
    }
  },
  createSpecifics: async (specifics) => {
    try {
      specifics.dueDate = Math.floor(new Date(specifics.dueDate).getTime() / 1000);
      specifics.billingDate = Math.floor(new Date(specifics.billingDate).getTime() / 1000);

      const result = await runQuery(queries.invoices.insertSpecifics(), [
        specifics.dueDate,
        specifics.billingDate,
        specifics.orderNumber,
        specifics.footer,
      ]);

      if (!result.affectedRows) throw new Error(`Error inserting specifics \n result: ${result}`);

      return result.insertId;
    } catch (err) {
      console.log(`
        createInvoiceSpecifics
        \x1b[31m${err}\x1b[0m\n
        specifics: ${specifics}
      `);

      return;
    }
  },
  createSpecificRelation: async (invoice, specific) => {
    try {
      const res = await runQuery(queries.invoices.insertSpecificRelation(), [invoice, specific]);
      if (!res.insertId) throw new Error(res);

      return res.insertId;
    } catch (err) {
      console.log(`\x1b[31m${err}\x1b[0m`);
      return;
    }
  },
  createItems: async (items) => {
    try {
      const ids = [];
      for (item of items) {
        console.log(item);
        const res = await runQuery(queries.invoices.insertItem(), [
          item.name,
          item.description,
          item.quantity,
          poundsToPennies(item.price),
          item.tax,
        ]);

        if (!res.insertId) throw new Error(res);
        ids.push(res.insertId);
      }

      return ids;
    } catch (err) {
      console.log(`invoices.createItems
      \x1b[31m${err}\x1b[0m`);
      return;
    }
  },
  createItemRelations: async (ids, invoice) => {
    try {
      const relationIds = [];
      for (id of ids) {
        const res = await runQuery(queries.invoices.insertItemRelation(), [invoice, id]);

        if (!res.insertId) throw new Error(res);
        relationIds.push(res.insertId);
      }

      return relationIds;
    } catch (err) {
      console.log(`invoices.createItemRelations
      \x1b[31m${err}\x1b[0m`);
      return;
    }
  },
};

module.exports = utils;
