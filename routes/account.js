const express = require("express");
const router = express.Router();

const { addToken, getTokenCreds } = require("../middleware/tokens");

const utils = require("../utils/account");
const compUtils = require("../utils/company");
const tokenUtils = require("../utils/tokens");
const { sendResetPassEmail } = require("../utils/sendInBlue");

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

  const token = await tokenUtils.updateResetToken(user, res);
  if (!token) return;

  const sent = await sendResetPassEmail(token, email, res);
  if (!sent) return;

  res.send({ status: 1 });
});

router.patch("/reset-password/:token/:email/:password", async function (req, res) {
  const { token, email, password } = req.params;

  if (!token || !email) {
    res.status(400).send({ status: 0 });
    return;
  }

  const resetId = await tokenUtils.getResetTokenId(token, res);
  if (!resetId) return;

  const userId = await utils.validateUserResetToken(email, resetId, res);
  if (!userId) return;

  const updated = await utils.updateUserPassword(userId, password, res);
  if (!updated) return;

  res.send({ status: 1 });
});

module.exports = router;
