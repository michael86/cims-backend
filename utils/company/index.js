const queries = require("../../mysql/query");
const { runQuery } = require("../sql");

const utils = {
  registerUserCompany: async (data, userId) => {
    try {
      const company = await utils.createCompany(data, true);

      if (!company || company instanceof Error) throw new Error(company);

      const relation = await utils.createUserRelation(userId, company);

      if (!relation) throw new Error(relation);

      return company;
    } catch (err) {
      console.log(`\x1b[31m${err}\x1b[0m`);
      return;
    }
  },

  getUserCompany: async (id) => {
    try {
      const [company] = await runQuery(queries.company.selectUserCompany(), [id]);
      console.log("company", company);
      if (company instanceof Error)
        throw new Error(`unable to get user company on log in, user id: ${id}`);

      return company;
    } catch (err) {
      console.log(`\x1b[31m${err}\x1b[0m`);
      return 0;
    }
  },

  createCompany: async (data, getCompany = false) => {
    try {
      let res = await runQuery(queries.company.insert(), [
        data.company,
        data.companyStreet,
        data.companyCity,
        data.companyCounty,
        data.companyPostcode,
        data.companyCountry,
      ]);

      if (res instanceof Error) throw new Error(`createCompany: ${res}`);
      if (res === "ER_DUP_ENTRY" && !getCompany) return res;

      if (res === "ER_DUP_ENTRY" && getCompany) {
        res = await utils.getCompany(data.company, data.companyPostcode);
        if (res instanceof Error) throw new Error(`createCompany: ${res}`);
      }

      return res.insertId || res.id;
    } catch (err) {
      return err;
    }
  },
  createUserRelation: async (userId, companyId) => {
    try {
      const relation = await runQuery(queries.company.insertUserCompanyRelation(), [
        userId,
        companyId,
      ]);

      if (!relation?.insertId) throw new Error(relation);

      return relation.insertId;
    } catch (err) {
      console.log(`\x1b[31m${err}"\x1b[0m"`);
      return;
    }
  },
  getCompany: async (name, postcode) => {
    try {
      let company = await runQuery(queries.company.select(), [name, postcode]);
      if (company instanceof Error) throw new Error(`getCompany: ${company}`);
      [{ ...company }] = company;

      return company;
    } catch (err) {
      return err;
    }
  },
};

module.exports = utils;
