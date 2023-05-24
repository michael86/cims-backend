const sha256 = require("sha256");
const { genToken } = require("../tokens");
const { getTokenCreds, addToken } = require("../../middleware/tokens");
const { runQuery } = require("../sql");
const queries = require("../../mysql/query");

const utils = {
  validateUserLogin: async (email, password) => {
    try {
      const [user] = await runQuery(queries.user.selectCreds(["password", "id"], "email"), [email]);

      if (user instanceof Error) throw new Error(`validateUserLogin: ${user}`);

      if (sha256(`${process.env.SALT}${password}`) !== user.password) return 0;

      return user.id;
    } catch (err) {
      return err;
    }
  },

  updateUserPassword: async (id, password) => {
    try {
      const pass = sha256(`${process.env.SALT}${password}`);
      const updateRes = await runQuery(queries.user.patch("password"), [pass, id]);

      if (updateRes instanceof Error) throw new Error(`updateUserPassword: ${updateRes}`);

      return true;
    } catch (err) {
      console.log(`error updating user \n
        password: ${sha256(`${process.env.SALT}${password}`)} \n
        id: ${id} \n 
        err: ${err}`);
      return;
    }
  },

  patchUserToken: async (email, id) => {
    try {
      const token = genToken();
      const { tokenId } = getTokenCreds(email);
      const result = await runQuery(queries.tokens.patch(), [token, tokenId]);

      if (!result?.affectedRows) throw new Error(`result: ${result}`);

      addToken(email, {
        userId: id,
        token,
        tokenId,
      });

      return token;
    } catch (err) {
      console.log(`error patching user token\nUser Id: ${id}\n ${err}`);
      return err;
    }
  },

  validateRegistrationData: (data) => {
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
      return data;
    return;
  },

  createUser: async (data) => {
    try {
      const userRes = await runQuery(queries.user.insert(), [
        data.email,
        sha256(`${process.env.SALT}${data.password}`),
      ]);

      if (userRes === "ER_DUP_ENTRY") return userRes;

      if (!userRes) throw new Error(userRes);

      return userRes;
    } catch (err) {
      console.log("error creating user: ", err);
      return;
    }
  },

  //any time we fail here, we still send 1 as a status as we don't want a malicious user knowing if request was partially successful.
  getUserDetails: async (targets, identifiers) => {
    try {
      const [user] = await runQuery(queries.user.selectCreds(targets, identifiers[0]), [
        identifiers[1],
      ]);

      if (user instanceof Error) throw new Error(user);

      return user;
    } catch (err) {
      return err;
    }
  },

  validateUserResetToken: async (email, tokenId) => {
    try {
      const [relation] = await runQuery(queries.tokens.selectResetEmail(), [tokenId]);

      if (!relation?.id || !relation?.email) throw new Error("Error getting user id");

      return email === relation.email ? relation.id : 0;
    } catch (err) {
      console.log(
        `error validating user reset token \n email: ${email} \n tokenId: ${tokenId} \n err: ${err}`
      );
      return;
    }
  },
};

module.exports = utils;
