const queries = require("../../mysql/query");
const { runQuery } = require("../sql");

const utils = {
  registerUserCompany: async (data, userId) => {
    try {
      const { insertId } = await runQuery(queries.insertCompany(), [
        data.company,
        data.companyStreet,
        data.companyCity,
        data.companyCounty,
        data.companyPostcode,
        data.companyCountry,
      ]);

      await runQuery(queries.insertUserCompanyRelation(), [userId, insertId]);

      return insertId;
    } catch (err) {
      console.log("error registering user company", err);
      return null;
    }
  },
};

module.exports = utils;
