const { select } = require("../../mysql/query");
const { genToken } = require("../../utils/tokens");
const { runQuery, updateToken } = require("../../utils/sql");
const queries = require("../../mysql/query");

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
  let { token } = req.headers;

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

      const updateRes = await updateToken("tokens", [["token", `'${newToken}'`]], ["id", tokenId]);

      if (!updateRes) {
        console.log("error updating user token in middleware", newToken);
      }

      next();

      return;
    }
  }

  //Account route has no validation, however, because I'm lazy and want to use the same dynamically generated contact component in the client for both auth and non auth users,
  //We need to validate the user when contacting company admin from the form, so here we are getting messy.
  //I may refactor support into its own route at some point. Depends if we need multiple contact routes.
  if (req.baseUrl === "/account") {
    next();
    return;
  }

  console.log("token not found/sent");
  res.send({ status: 0 });
  return;
};

//This should only ever be called if we're 1000000000%!!!!! certain that this user is genuine
module.exports.addToken = (email, payload) => (authenticatedUsers[email] = { ...payload });

module.exports.initTokenCache = async () => {
  try {
    console.log("initiating token cache");
    const users = await runQuery(select("users", ["email", "id"]));

    for (const { id: userId, email } of users) {
      const token = await runQuery(queries.tokens.select(), [userId]);

      if (token instanceof Error) throw new Error(`initTokenCache: ${token}`);

      this.addToken(email, {
        userId,
        token: token[0].value,
        tokenId: token[0].id,
      });
    }
  } catch (err) {
    console.log(`Error initiating token cache\n${err}`);
  }
};

module.exports.getTokenCreds = (email, token) =>
  token
    ? authenticatedUsers[email].token === token
      ? authenticatedUsers[email]
      : null
    : authenticatedUsers[email];
