const sha256 = require("sha256");
const { genToken } = require("../tokens");
const { getTokenCreds, addToken } = require("../../middleware/tokens");
const { runQuery } = require("../sql");
const queries = require("../../mysql/query");

const utils = {
  validateUserLogin: async (email, password, res) => {
    try {
      const [user] = await runQuery(queries.getUserCreds(["password", "id"], "email"), [email]);

      if (user && sha256(`${process.env.SALT}${password}`) === user.password) return user.id;

      res.send({ status: 2 });
      return;
    } catch (err) {
      console.log(`error logging user (${email}) in: `, err);
      res.status(500).send({ status: 2 });
      return;
    }
  },

  patchUserToken: async (email, id, res) => {
    try {
      const token = genToken();
      const { tokenId } = getTokenCreds(email);
      const result = await runQuery(queries.patchUserToken(), [token, tokenId]);

      if (!result || !result.affectedRows) {
        res.status(500).send({ status: 0 });
        return;
      }

      addToken(email, {
        userId: id,
        token,
        tokenId,
      });

      return token;
    } catch (err) {
      console.log(`error patching user (${id}) token: `, err);
      res.status(500).send({ status: 0 });
      return err;
    }
  },

  validateRegistrationData: (data, res) => {
    if (
      data.email &&
      data.password &&
      data.company &&
      data.companyStreet &&
      data.companyCity &&
      data.companyCounty &&
      data.companyPostcode &&
      data.companyCountry &&
      typeof data.pricePlan === "number"
    )
      return { ...data };

    res.status(400).send({ status: 0 });
    return;
  },

  createUser: async (data, res) => {
    try {
      const userRes = await runQuery(queries.insertUser(), [
        data.email,
        sha256(`${process.env.SALT}${data.password}`),
      ]);

      if (userRes === "ER_DUP_ENTRY") {
        res.send({ status: 2 });
        return;
      }

      if (!userRes) {
        res.status(500).send({ status: 3 });
        return;
      }

      return userRes;
    } catch (err) {
      console.log("error creating user: ", err);
      res.status(500).send({ status: 3 });
      return;
    }
  },
};

module.exports = utils;
