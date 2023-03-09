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

      const { insertId: tokenId } = await runQuery(queries.insertUserToken(), [token]);

      const { insertId: connection } = await runQuery(queries.insertUserTokenRelation(), [
        userId,
        tokenId,
      ]);

      if (!tokenId || !connection) {
        res.status(500).send({ status: 3 });
        return;
      }

      return { value: token, id: tokenId, connection };
    } catch (err) {
      console.log("error creating user token", err);
      res.status(500).send({ status: 3 });
      return;
    }
  },

  deleteUserToken: async ({ tokenId }, res) => {
    try {
      const result = await runQuery(queries.patchUserToken(), [null, tokenId]);

      if (!result) {
        res.status(500).send({ status: 0 });
        return;
      }

      return result;
    } catch (err) {
      console.log(`error updating user token ${tokenId} \n ${err}`);
    }
  },

  createResetToken: async (token, userId) => {
    try {
      const tokenRes = await runQuery(queries.insertResetToken(), [token]);

      if (!tokenRes?.affectedRows)
        throw new Error(`Error inserting reset token ${token} \n res: ${tokenRes}`);

      const relationship = await runQuery(queries.insertResetRelation(), [
        userId,
        tokenRes.insertId,
      ]);

      if (!relationship?.affectedRows)
        throw new Error(`Error getting relationship ${relationship}`);

      return true;
    } catch (err) {
      console.log(
        `error creating user_reset token \n token: ${token} \n user: ${user} \n error: ${err}`
      );
      return;
    }
  },

  patchResetToken: async (token, relation) => {
    try {
      const tokenRes = await runQuery(queries.patchResetToken(), [token, relation]);

      if (!tokenRes?.affectedRows) throw new Error(`Error patching reset token ${tokenRes}`);

      return true;
    } catch (err) {
      console.log(
        `error patching user_reset token \n token: ${token} \n relation: ${relation} \n error: ${err}`
      );
      return;
    }
  },

  updateResetToken: async ({ id: userId }, res) => {
    try {
      const token = utils.genToken(50, false);

      const [tokenId] = await runQuery(queries.selectResetRelation(), [userId]);

      const created = tokenId
        ? await utils.patchResetToken(token, tokenId.value)
        : await utils.createResetToken(token, userId);

      if (!created) {
        res.status(500).send({ status: 0 });
        throw new Error(`Error creating reset token ${created}`);
      }

      return token;
    } catch (err) {
      console.log(`error creating user reset token \n user: ${userId} \n error: ${err}`);
      res.status(500).send({ status: 0 });
      return;
    }
  },
};

module.exports = utils;
