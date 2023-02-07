const { select } = require("../../mysql/query");
const { genToken } = require("../../utils");
const { runQuery, updateToken } = require("../../utils/sql");

const authenticatedUsers = {};

module.exports.authenticate = (req, res, next) => {
  const { token } = req.headers;
  const { email } = req.body;

  if (!authenticatedUsers[email] || authenticatedUsers[email].token !== token) {
    res.send({ status: 0, error: "authentification failed" });
    return;
  }

  const newToken = genToken();
  req.newToken = newToken;
  authenticatedUsers[email].token = newToken;

  next();
};

module.exports.validateToken = async (req, res, next) => {
  const { token } = req.headers;

  for (const user in authenticatedUsers) {
    if (authenticatedUsers[user].token === token) {
      const newToken = genToken();

      const { userId, tokenId, connection } = authenticatedUsers[user];
      req.headers.newToken = newToken;
      req.headers.userId = userId;
      req.headers.tokenId = tokenId;
      req.headers.connection = connection;
      req.headers.email = user;
      authenticatedUsers[user].token = newToken;

      const updateRes = await updateToken(
        "tokens",
        [["token", `'${newToken}'`]],
        ["id", tokenId]
      );

      if (!updateRes) {
        console.log("error updating user token in middleware", newToken);
      }

      next();

      return;
    }
  }

  console.log("token not found/sent");
  res.send({ status: 0 });
  return;
};

//This should only ever be called if we're 1000000000%!!!!! certain that this user is genuine
module.exports.addToken = (email, payload) =>
  (authenticatedUsers[email] = { ...payload });

module.exports.initTokenCache = async () => {
  await runQuery(select("users", ["email", "id"])).then(async (res) => {
    for (const user of res) {
      const { id: userId, email } = user;

      const [connection] = await runQuery(
        select("user_token", ["token", "id"], "user"),
        [userId]
      );

      const { token: tokenId, id: connectionId } = connection;

      const [userToken] = await runQuery(select("tokens", ["token"], "id"), [
        tokenId,
      ]);

      const { token } = userToken;

      this.addToken(email, {
        userId,
        token,
        tokenId,
      });
    }
  });
};

module.exports.getTokenCreds = (email) => authenticatedUsers[email];
