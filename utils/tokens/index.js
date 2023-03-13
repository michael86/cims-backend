const queries = require("../../mysql/query");
const { runQuery } = require("../sql");

const utils = {
  genToken: (count = 50, includeSpecial = true) => {
    let letters = `abcdefghijklmnopqrstuvwxyzABCDEFGHIHJKLMNOPQRSTUVWXYZ1234567890${
      includeSpecial && '!"£$%^&*()_+-'
    }`;

    let token = "";
    for (let i = 0; i <= count; i++) {
      token += letters.charAt(Math.floor(Math.random() * letters.length));
    }

    return (token += Date.now());
  },

  createUserToken: async (userId, res) => {
    try {
      const token = utils.genToken();

      const tokenId = await runQuery(queries.tokens.insert(), [token]);
      if (!tokenId?.insertId) throw new Error(tokenId);

      const connection = await runQuery(queries.tokens.insertRelation(), [
        userId,
        tokenId.insertId,
      ]);

      if (!connection?.insertId) throw new Error(connection);

      return { value: token, id: tokenId.insertId, connection: connection.insertId };
    } catch (err) {
      console.log(err);
      return;
    }
  },

  deleteUserToken: async ({ tokenId }, res) => {
    try {
      const result = await runQuery(queries.tokens.patch(), [null, tokenId]);

      if (!result) {
        res.status(500).send({ status: 0 });
        return;
      }

      return result;
    } catch (err) {
      console.log(`error updating user token ${tokenId} \n ${err}`);
    }
  },

  createResetToken: async (token, id) => {
    try {
      const tokenRes = await runQuery(queries.tokens.insertResetToken(), [token]);

      if (!tokenRes?.affectedRows) throw new Error(tokenRes);

      const relationship = await runQuery(queries.tokens.insertResetRelation(), [
        id,
        tokenRes.insertId,
      ]);

      if (!relationship?.affectedRows) throw new Error(relationship);

      return true;
    } catch (err) {
      console.log(`Error createResetToken \n token: ${token} \n id: ${id} \n error: ${err}`);
      return err;
    }
  },

  patchResetToken: async (token, relation) => {
    try {
      const tokenRes = await runQuery(queries.tokens.patchResetToken(), [token, relation]);

      if (!tokenRes?.affectedRows) throw new Error(`Error patching reset token ${tokenRes}`);

      return true;
    } catch (err) {
      console.log(
        `error patchResetToken \n token: ${token} \n relation: ${relation} \n error: ${err}`
      );
      return err;
    }
  },

  updateResetToken: async ({ id: userId }) => {
    try {
      const token = utils.genToken(50, false);

      const [tokenId] = await runQuery(queries.tokens.selectResetRelation(), [userId]);

      const created = tokenId
        ? await utils.patchResetToken(token, tokenId.value)
        : await utils.createResetToken(token, userId);

      if (!created) throw new Error(created);

      return token;
    } catch (err) {
      console.log(`error creating user reset token \n user: ${userId} \n error: ${err}`);
      return;
    }
  },

  getResetTokenId: async (token, res) => {
    try {
      const [tokenRes] = await runQuery(queries.tokens.selectResetId(), [token]);

      if (!tokenRes?.id) throw new Error(tokenRes);

      return tokenRes.id;
    } catch (err) {
      console.log(`Error getting reset_token id \n token: ${token} \n error: ${err}`);
      return;
    }
  },
};

module.exports = utils;
