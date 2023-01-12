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
    console.log(user);
    if (authenticatedUsers[user].token === token) {
      console.log("found");
      next();
      return;
    }
  }

  res.send({ status: -1 });
  return;
};

//This should only ever be called if we're 1000000000%!!!!! certain that this user is genuine
module.exports.addToken = (email, token) => {
  authenticatedUsers[email] = {};
  authenticatedUsers[email].token = token;
};
