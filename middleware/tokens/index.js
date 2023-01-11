const { genToken } = require("../../utils");

const authenticatedUsers = {
  "michael8t6@gmail.com": {
    token: "123",
  },
};

module.exports.authenticate = (req, res, next) => {
  const { token } = req.headers;
  const { email } = req.body;

  console.log(
    !authenticatedUsers[email] || authenticatedUsers[email].token !== token
  );

  if (!authenticatedUsers[email] || authenticatedUsers[email].token !== token) {
    res.send({ status: 0, error: "authentification failed" });
    return;
  }

  const newToken = genToken();
  req.newToken = newToken;
  authenticatedUsers[email].token = newToken;

  next();
};
