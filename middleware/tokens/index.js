const { select } = require("../../mysql/query");
const { genToken } = require("../../utils");
const { runQuery } = require("../../utils/sql");

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

module.exports.validateToken = (req, res, next) => {
  const { token } = req.headers;

  for (const user in authenticatedUsers) {
    if (authenticatedUsers[user].token === token) {
      const newToken = genToken();

      req.headers.newToken = newToken;
      req.headers.userId = authenticatedUsers[user].userId;
      req.headers.tokenId = authenticatedUsers[user].tokenId;
      req.headers.connection = authenticatedUsers[user].connection;
      authenticatedUsers[user].token = newToken;

      next();

      return;
    }
  }

  res.send({ status: 0 });
  return;
};

//This should only ever be called if we're 1000000000%!!!!! certain that this user is genuine
module.exports.addToken = (email, payload) => {
  authenticatedUsers[email] = { ...payload };
  // console.log("addToken", authenticatedUsers);
};

module.exports.initTokenCache = async () => {
  await runQuery(select("users", ["email", "id"])).then(async (res) => {
    for (const user of res) {
      const { id: userId, email } = user;

      const [connection] = await runQuery(
        select("user_token", ["token", "id"], "user"),
        [userId]
      );

      if (!connection) continue;

      const { token: tokenId, id: connectionId } = connection;

      const [userToken] = await runQuery(select("tokens", ["token"], "id"), [
        tokenId,
      ]);

      const { token } = userToken;

      this.addToken(email, {
        userId,
        token,
        tokenId,
        connection: connectionId,
      });
    }
  });
};

module.exports.updateToken = (oldToken, newToken) => {};
