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

  createUserToken: async (userId) => {
    try {
      const token = utils.genToken();

      const { insertId: tokenId } = await runQuery(queries.insertUserToken(), [
        token,
      ]);

      const { insertId: connection } = await runQuery(
        queries.insertUserTokenRelation(),
        [userId, tokenId]
      );

      return { value: token, id: tokenId, connection };
    } catch (err) {
      console.log("error creating user token", err);
      return null;
    }
  },
};

module.exports = utils;
