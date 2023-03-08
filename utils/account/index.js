const sha256 = require("sha256");
const { genToken } = require("../tokens");
const { getTokenCreds, addToken } = require("../../middleware/tokens");
const { runQuery } = require("../sql");
const queries = require("../../mysql/query");
const compUtils = require("../company");

const utils = {
  validateUserLogin: async (email, password) => {
    const [user] = await runQuery(
      queries.getUserCreds(["password", "id"], "email"),
      [email]
    );

    const shaPass = sha256(`${process.env.SALT}${password}`);
    return user && shaPass === user.password ? user.id : null;
  },

  patchUserToken: async (email, id) => {
    try {
      const token = genToken();
      const { tokenId } = getTokenCreds(email);
      const result = await runQuery(queries.patchUserToken(), [token, tokenId]);

      result.affectedRows &&
        addToken(email, {
          userId: id,
          token,
          tokenId,
        });

      return result.affectedRows ? token : null;
    } catch (err) {
      console.log(err);
      return err;
    }
  },

  validateRegistrationData: (data) => {
    return data.email &&
      data.password &&
      data.company &&
      data.companyStreet &&
      data.companyCity &&
      data.companyCounty &&
      data.companyPostcode &&
      data.companyCountry &&
      typeof data.pricePlan === "number"
      ? { ...data }
      : null;
  },

  createUser: async (data) => {
    const userRes = await runQuery(queries.insertUser(), [
      data.email,
      sha256(`${process.env.SALT}${data.password}`),
    ]);

    return userRes;
  },
};

module.exports = utils;
