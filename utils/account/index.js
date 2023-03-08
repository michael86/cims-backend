const { genToken } = require("../tokens");
const { getTokenCreds, addToken } = require("../../middleware/tokens");
const { runQuery } = require("../sql");
const queries = require("../../mysql/query");

module.exports.patchUserToken = async (email, id) => {
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
};
