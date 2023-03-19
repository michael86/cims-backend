const queries = require("../../mysql/query");
const { runQuery } = require("../sql");
const { poundsToPennies } = require("../generic");
const path = require("node:path");
const easyinvoice = require("easyinvoice");
const fs = require("fs");

const utils = {
  createCompany: async (data) => {
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

        if (invoice instanceof Error) throw new Error(invoice);

        console.log("itemIds", invoice);
        [{ ...invoice }] = invoice;

        const itemIds = await runQuery(queries.invoices.selectItemIds(), id);
        if (itemIds instanceof Error) throw new Error(itemIds);

        const items = await utils.getItems(itemIds);

        invoice.items = items.map((item) => {
          const i = { ...item[0] };
          i.price = (i.price / 100).toFixed(2);
          return i;
        });

        invoices.push(invoice);
      }
      return invoices;
    } catch (err) {
      console.log(2);
      return err;
    }
  },
  createFile: async ([data], userId) => {
    try {
      let company = await runQuery(queries.company.selectUserCompany(), [userId]);
      if (company instanceof Error) throw new Error(company);
      [{ ...company }] = company;

      const items = [];

      for (const item of data.items) {
        items.push({
          quantity: item.quantity,
          description: `${item.sku}: ${item.description}`,
          "tax-rate": item.tax,
          price: parseFloat(item.price),
        });
      }

      const template = path.join(__dirname, "..", "..", "utils/invoices", "template.html");

      const invoiceDetail = {
        customize: {
          template: fs.readFileSync(template, "base64"), // Must be base64 encoded html
        },
        images: {
          logo: "https://avatars.githubusercontent.com/u/24959057?s=400&u=c327230943159112b4851d5f0b0a0602950abcde&v=4",
        },
        sender: {
          company: company.name,
          address: company.address,
          zip: company.postcode,
          city: company.city,
          country: company.country,
          custom1: company.county,
        },
        client: {
          company: data.name,
          custom1: data.contact,
          address: data.address,
          custom2: data.state,
          zip: data.postcode,
          city: data.city,
          country: data.country,
        },
        information: {
          number: data.orderNumber,
          date: new Date(data.billingDate * 1000).toLocaleDateString(),
          "due-date": new Date(data.dueDate * 1000).toLocaleDateString(),
        },
        products: items,
        "bottom-notice": data.footer,
        settings: {
          currency: "GBP", // See documentation 'Locales and Currency' for more info. Leave empty for no currency.
          // "locale": "nl-NL", // Defaults to en-US, used for number formatting (see docs)
          // "taxNotation": "gst", // Defaults to vat
          // "margin-top": 25, // Default to 25
          // "margin-right": 25, // Default to 25
          // "margin-left": 25, // Default to 25
          // "margin-bottom": 25, // Default to 25
          // "format": "Letter", // Defaults to A4
          // "height": "1000px", // allowed units: mm, cm, in, px
          // "width": "500px", // allowed units: mm, cm, in, px
          // "orientation": "landscape", // portrait or landscape, defaults to portrait
        },
      };

      const fileName = `${data.contact.replaceAll(" ", "-")}-${data.name}.pdf`;
      const filePath = path.join(__dirname, "..", "..", "public/invoices", fileName);
      const result = await easyinvoice.createInvoice(invoiceDetail);
      await fs.writeFileSync(filePath, result.pdf, "base64"); //This triggers the catch if fails, so no need to check for errors.

      return fileName;
    } catch (err) {
      return err;
    }
  },
};

module.exports = utils;
