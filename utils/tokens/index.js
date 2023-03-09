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

  createResetToken: async (user, res) => {
    try {
      const token = utils.genToken(50, false);

      const [tokenId] = await runQuery(queries.getResetRelation(), [user.id]);

      const created = tokenId
        ? await updateUserResetToken(token, relation)
        : await createUserResetToken(token, user);

      if (!created) {
        res.status(500).send({ status: 0 });
        return;
      }
    } catch (err) {
      console.log(`error creating user reset token \n user: ${user} \n error: ${err}`);
      res.status(500).send({ status: 0 });
      return;
    }
  },
};

module.exports = utils;
