const sha256 = require("sha256");
const { genToken } = require("../tokens");
const { getTokenCreds, addToken } = require("../../middleware/tokens");
const { runQuery } = require("../sql");
const queries = require("../../mysql/query");

const utils = {
  validateUserLogin: async (email, password) => {
    try {
      const [user] = await runQuery(queries.user.selectCreds(["password", "id"], "email"), [email]);

      if (!user) throw new Error("Error selecint user");
      if (sha256(`${process.env.SALT}${password}`) !== user.password) return 0;

      return user.id;
    } catch (err) {
      console.log(`
      error logging user in
      ${email}
      ${err}`);
      return;
    }
  },

  updateUserPassword: async (id, password, res) => {
    try {
      const pass = sha256(`${process.env.SALT}${password}`);
      const updateRes = await runQuery(queries.patchUser("password"), [pass, id]);

      if (!updateRes?.affectedRows) throw new Error(`affectedRows is null`);

      return true;
    } catch (err) {
      console.log(
        `error updating user \n
        password: ${sha256(`${process.env.SALT}${password}`)} \n
        id: ${id} \n 
        err: ${err}`
      );
      res.status(500).send({ status: 0 });
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
      return;
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
  getUserDetails: async (targets, identifiers, res) => {
    try {
      const [user] = await runQuery(queries.selectUserCreds(targets, identifiers[0]), [
        identifiers[1],
      ]);

      if (!user) throw new Error("Error getting user details");

      return { ...user };
    } catch (err) {
      console.log(
        `error getting user details \n targets: ${targets} \n identifiers: ${identifiers} \n error: ${err}`
      );
      res.status({ status: 1 });
      return;
    }
  },

  validateUserResetToken: async (email, tokenId, res) => {
    try {
      const [relation] = await runQuery(queries.selectResetEmail(), [tokenId]);

      if (!relation) throw new Error("Error getting user id");

      if (email !== relation.email) {
        res.send({ status: 0 });
        return;
      }

      //At this point, everything seems to match.
      //We got the token id based on the query param, then used that to get the email for the related user_id
      //So update password
      return relation.id;
    } catch (err) {
      console.log(
        `error validating user reset token \n email: ${email} \n tokenId: ${tokenId} \n err: ${err}`
      );
      return;
    }
  },
};

module.exports = utils;
