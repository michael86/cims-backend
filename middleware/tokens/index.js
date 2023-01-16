const { genToken } = require("../../utils");

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
  console.log("addToken", authenticatedUsers);
};

module.exports.updateToken = (oldToken, newToken) => {};
