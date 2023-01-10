const { genToken } = require("../../utils");

const authenticatedUsers = {
  "::ffff:127.0.0.1": {
    token: "123",
  },
};

module.exports.authenticate = (req, res, next) => {
  const { token } = req.headers;
  const { remoteAddress } = req.socket;

  if (
    !authenticatedUsers[remoteAddress] ||
    authenticatedUsers[remoteAddress].token !== token
  ) {
    res.send({ status: 0, error: "authentification failed" });
    return;
  }

  req.newToken = genToken();

  next();
};
