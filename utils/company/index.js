const queries = require("../../mysql/query");
const { runQuery } = require("../sql");

const utils = {
  registerUserCompany: async (data, userId, res) => {
    try {
      const insertId = utils.insertCompany(data);
      if (!insertId) return;

      const relation = await runQuery(queries.insertUserCompanyRelation(), [userId, insertId]);
      if (!relation) throw new Error(`Error creating userCompanyRelation: ${relation}`);

      return insertId;
    } catch (err) {
      res.status(500).send({ status: 3 });
      console.log("error registering user company", err);
      return;
    }
  },

  getUserCompany: async (id, res) => {
    try {
      const [company] = await runQuery(queries.selectUserCompany(), [id]);
      if (!company) throw new Error(`unable to get user company on log in, user id: ${id}`);

      return company;
    } catch (err) {
      console.log(`error selecting userCompany: `, err);
      res.status(500).send({ status: 0 });
      return;
    }
  },

  insertCompany: async (data, res, returnToken = false) => {
    try {
      const insertId = await runQuery(queries.insertCompany(), [
        data.company,
        data.companyStreet,
        data.companyCity,
        data.companyCounty,
        data.companyPostcode,
        data.companyCountry,
      ]);

      if (!insertId.affectedRows) throw new Error(`insert Id invalid: ${insertId}`);

      return insertId;
    } catch (err) {
      console.log(`Error inserting company \n data: ${data} \n err: ${err}`);

      returnToken
        ? res.status(500).send({ status: 0, token: res.headers.newToken })
        : res && res.status(500).send({ status: 0 });
      return;
    }
  },
};

module.exports = utils;
