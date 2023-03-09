const queries = require("../../mysql/query");
const { runQuery } = require("../sql");

const utils = {
  registerUserCompany: async (data, userId, res) => {
    try {
      const { insertId } = await runQuery(queries.insertCompany(), [
        data.company,
        data.companyStreet,
        data.companyCity,
        data.companyCounty,
        data.companyPostcode,
        data.companyCountry,
      ]);

      const relation = await runQuery(queries.insertUserCompanyRelation(), [userId, insertId]);

      if (!insertId || !relation) {
        res.status(500).send({ status: 3 });
        return;
      }

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

      if (!company) {
        console.log("unable to get user company on log in, user id: ", id);
        res.status(500).send({ status: 0 });
        return;
      }

      return company;
    } catch (err) {
      console.log(`error selecting userCompany (${id}): `, err);
      res.status(500).send({ status: 0 });
      return;
    }
  },
};

module.exports = utils;
