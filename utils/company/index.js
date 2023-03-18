const queries = require("../../mysql/query");
const { runQuery } = require("../sql");

const utils = {
  registerUserCompany: async (data, userId) => {
    try {
      const company = await utils.insertCompany(data);
      if (!company?.insertId) throw new Error(insertId);

      const relation = await utils.createUserRelation(userId, company.insertId);

      if (!relation) throw new Error(relation);

      return company.insertId;
    } catch (err) {
      console.log(`\x1b[31m${err}\x1b[0m`);
      return;
    }
  },

  getUserCompany: async (id) => {
    try {
      const [company] = await runQuery(queries.company.selectUserCompany(), [id]);

      if (!company) throw new Error(`unable to get user company on log in, user id: ${id}`);

      return company;
    } catch (err) {
      console.log(`\x1b[31m${err}\x1b[0m`);
      return 0;
    }
  },

  createCompany: async (data) => {
    try {
      const insertId = await runQuery(queries.company.insert(), [
        data.company,
        data.companyStreet,
        data.companyCity,
        data.companyCounty,
        data.companyPostcode,
        data.companyCountry,
      ]);

      if (insertId instanceof Error) throw new Error(`createCompany: ${insertId}`);

      return insertId;
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
};

module.exports = utils;
