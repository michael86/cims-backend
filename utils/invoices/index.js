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
      return err;
    }
  },
  createUserRelation: async (user, invoice) => {
    try {
      const res = await runQuery(queries.invoices.insertUserRelation(), [user, invoice]);

      if (!res.insertId) throw new Error(res);

      return res.insertId;
    } catch (err) {
      return err;
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
      return err;
    }
  },
  createSpecificRelation: async (invoice, specific) => {
    try {
      const res = await runQuery(queries.invoices.insertSpecificRelation(), [invoice, specific]);
      if (!res.insertId) throw new Error(res);

      return res.insertId;
    } catch (err) {
      return err;
    }
  },
  createItems: async (items) => {
    try {
      const ids = [];
      for (item of items) {
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
      return err;
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
      return err;
    }
  },

  getInvoiceIds: async (user) => {
    try {
      let userInvoices = await runQuery(queries.invoices.selectIds(), [user]);

      if (!Array.isArray(userInvoices)) throw new Error(userInvoices);

      return userInvoices.map(({ id }) => id);
    } catch (err) {
      return err;
    }
  },

  getItems: async (ids) => {
    try {
      const items = [];
      for (const { id } of ids) {
        const item = await runQuery(queries.invoices.selectItem(), [id]);
        if (!Array.isArray(item)) throw new Error(item);
        items.push(item);
      }
      return items;
    } catch (err) {
      return err;
    }
  },

  getInvoices: async (ids) => {
    try {
      const invoices = [];
      for (const id of ids) {
        let invoice = await runQuery(queries.invoices.select(), [id, id]);

        if (!Array.isArray(invoice)) throw new Error(invoice);
        [{ ...invoice }] = invoice; //runQuery returns an object inside an array, so destructure it.

        const itemIds = await runQuery(queries.invoices.selectItemIds(), id);
        if (!Array.isArray(itemIds)) throw new Error(itemIds);

        const items = await utils.getItems(itemIds);

        invoice.items = items.map((item) => {
          const i = { ...item[0] };
          i.price = (i.price / 100).toFixed(2);
          return i;
        });

        // console.log(invoice);
        invoices.push(invoice);
      }
      return invoices;
    } catch (err) {
      console.log(2);
      return err;
    }
  },
};

module.exports = utils;
