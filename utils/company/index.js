const queries = require("../../mysql/query");
const { runQuery } = require("../sql");

const utils = {
  registerUserCompany: async (data, userId) => {
    try {
      const company = await utils.insertCompany(data);
      if (!company?.insertId) throw new Error(insertId);

      const relation = await runQuery(queries.company.insertUserCompanyRelation(), [
        userId,
        company.insertId,
      ]);

      if (!relation?.insertId) throw new Error(relation);

      return company.insertId;
    } catch (err) {
      console.log("error registering user company", err);
      return;
    }
  },

  getUserCompany: async (id) => {
    try {
      const [company] = await runQuery(queries.company.selectUserCompany(), [id]);

      if (!company) throw new Error(`unable to get user company on log in, user id: ${id}`);

      return company;
    } catch (err) {
      console.log(err);
      return 0;
    }
  },

  insertCompany: async (data) => {
    try {
      const insertId = await runQuery(queries.company.insert(), [
        data.company,
        data.companyStreet,
        data.companyCity,
        data.companyCounty,
        data.companyPostcode,
        data.companyCountry,
      ]);

      if (!insertId.affectedRows) throw new Error(insertId);

      // const relation = await runQuery(queries.insertInvoiceCompanyRelation(), [userId, companyId]);
      // if (!relation) throw new Error(relation);

      return insertId;
    } catch (err) {
      console.log(`Error inserting company \n data: ${data} \n err: ${err}`);

      return;
    }
  },
};

module.exports = utils;
