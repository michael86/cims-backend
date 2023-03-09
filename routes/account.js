const express = require("express");
const { update, select } = require("../mysql/query");
const utils = require("../utils/account");
const compUtils = require("../utils/company");
const tokenUtils = require("../utils/tokens");
const router = express.Router();
const sha256 = require("sha256");
const { genToken } = require("../utils");
const { runQuery, createUserResetToken, updateUserResetToken } = require("../utils/sql");

const { sendEmail } = require("../utils/sendInBlue");
const { forgotPassword } = require("../emails/forgot-password");
const { addToken, getTokenCreds } = require("../middleware/tokens");

router.put("/login", async function (req, res) {
  const { email, password } = req.body;

  if (!email || !password) {
    res.send({ status: 1, error: "credentials not sent" });
    return;
  }

  const userId = await utils.validateUserLogin(email, password, res);
  if (!userId) return;

  const company = await compUtils.getUserCompany(userId);
  if (!company) return;

  const token = await utils.patchUserToken(email, userId, res);
  if (!token) return;

  res.send({
    status: 1,
    token,
    email,
    company,
  });
});

router.put("/register", async function (req, res) {
  const account = await utils.validateRegistrationData(req.body.data, res);
  if (!account) return;

  const user = await utils.createUser(account, res);
  if (!user) return;

  const company = await compUtils.registerUserCompany(account, user.insertId, res);
  if (!company) {
    return;
  }

  const token = await tokenUtils.createUserToken(user.insertId, res);
  if (!token) return;

  addToken(account.email, {
    userId: user.insertId,
    token: token.value,
    tokenId: token.id,
  });

  res.send({
    status: 1,
    data: {
      user: { email: account.email, token: token.value, authenticated: true },
      company: {
        name: account.company,
        street: account.companyStreet,
        city: account.companyCity,
        county: account.companyCounty,
        postcode: account.companyPostcode,
        country: account.companyCountry,
      },
    },
  });
});

router.delete("/logout", async function (req, res) {
  const { token } = req.headers;
  const { email } = req.body;

  if (!token || !email) {
    res.status(400).send({ status: 0 });
    return;
  }

  const result = await tokenUtils.deleteUserToken(getTokenCreds(email, token), res);
  if (!result) return;

  res.send({ status: 1 });
});

router.put("/forgot-password", async function (req, res) {
  const { email } = req.body;

  if (!email) {
    res.status(400).send({ status: 0 });
    return;
  }

  const user = await utils.getUserDetails(["id", "email"], ["email", email], res);
  if (!user) return;

  const token = await tokenUtils.createResetToken(user, res);
  if (!token) return;

  const params = {
    route: `${process.env.ROOT}/reset-password?token=${token}&email=${email}`,
  };

  const emailSent = await sendEmail({
    receivers: [email],
    subject: "forgotPassword",
    htmlContent: forgotPassword,
    params,
  });

  if (!emailSent) {
    res.status(500).send({ status: 0 });
  }

  res.send({ status: 1 });
});

router.patch("/reset-password/:token/:email/:password", async function (req, res) {
  const { token, email, password } = req.params;

  if (!token || !email) {
    res.status(400).send({ status: 0 });
    return;
  }

  const [tokenRes] = await runQuery(select("reset_tokens", ["id"], "token"), [token]);

  if (!tokenRes) {
    console.log("token not found, forbidden");
    res.status(403).send({ status: 0 });
    return;
  }

  const [userRes] = await runQuery(select("users", ["id"], "email"), [email]);

  const [relationRes] = await runQuery(select("user_reset", ["user_id"], "token_id"), [
    tokenRes.id,
  ]);

  //Something didn't match up or the token received didn't match the email issued to. So stop here.
  if (!tokenRes || !userRes || !relationRes || relationRes?.user_id !== userRes.id) {
    res.send({ status: 0 });
    return;
  }

  const updateRes = await runQuery(update("users", [["password"]], ["email"]), [
    sha256(`${process.env.SALT}${password}`),
    email,
  ]);

  if (!updateRes) {
    res.status(500).send({ status: 0 });
  }
  res.send({ status: 1 });
});

module.exports = router;
