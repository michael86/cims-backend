const express = require("express");
const asyncMySQL = require("../mysql/connection");
const {
  getUserCreds,
  insertUserToken,
  insertUserTokenConnection,
  createUser,
  createCompany,
  connectUserCompany,
  getUserCompany,
  update,
  select,
  insert,
} = require("../mysql/query");

const router = express.Router();
const sha256 = require("sha256");
const { addToken, getTokenCreds } = require("../middleware/tokens");
const { genToken } = require("../utils");
const {
  runQuery,
  createUserResetToken,
  updateUserResetToken,
} = require("../utils/sql");
const { sendEmail } = require("../utils/sendInBlue");
const { forgotPassword } = require("../emails/forgot-password");

router.put("/logout", async function (req, res) {
  await asyncMySQL();

  res.send({ status: 1 });
});

router.put("/login", async function (req, res) {
  const { email, password } = req.body;

  if (!email || !password) {
    res.send({ status: 1, error: "credentials not sent" });
    return;
  }

  try {
    //Get rest of users details via joining
    const [user] = await runQuery(getUserCreds(["password", "id"], "email"), [
      email,
    ]);

    const shaPass = sha256(`${process.env.SALT}${password}`);

    if (!user || shaPass !== user.password) {
      //Add some sort of check here to catch brute force
      res.send({ status: 2 });
      return;
    }

    const token = genToken();

    const { tokenId } = getTokenCreds(email);

    const result = await runQuery(
      update("tokens", [["token", `'${token}'`]], ["id", tokenId])
    );

    if (!result) {
      console.log("error logging user in");
      res.status(500).send();
    }

    const [company] = await runQuery(getUserCompany(), [user.id]);

    if (!company) {
      console.log("unable to get user company on log in, user id: ", user.id);
      res.status(500).send({ status: 0 });
      return;
    }
    console.log("rerm");
    addToken(email, {
      userId: user.id,
      token,
      tokenId: tokenId,
    });

    res.send({
      status: 1,
      token,
      email,
      company,
    });
  } catch (error) {
    console.log("log in route error: ", error);
    res.send({ status: -1, error: "Login failed" });
  }
});

router.put("/register", async function (req, res) {
  const {
    email,
    password,
    company,
    companyStreet,
    companyCity,
    companyCounty,
    companyPostcode,
    companyCountry,
    pricePlan,
  } = req.body.data;

  if (
    !email ||
    !password ||
    !company ||
    !companyStreet ||
    !companyCity ||
    !companyCounty ||
    !companyPostcode ||
    !companyCountry ||
    typeof pricePlan !== "number"
  ) {
    res.send({ status: 0, error: "Invalid registration" });
  }

  const userRes = await runQuery(createUser(), [
    email,
    sha256(`${process.env.SALT}${password}`),
  ]);

  if (userRes === "ER_DUP_ENTRY") {
    res.send({ status: 2 });
    return;
  }

  const { insertId: userId } = userRes;

  const { insertId: companyId } = await runQuery(createCompany(), [
    company,
    companyStreet,
    companyCity,
    companyCounty,
    companyPostcode,
    companyCountry,
  ]);

  if (!userId || !companyId) {
    console.log("failed to insert user or company on registration");
    res.status(500).send({ status: 0 });
    return;
  }

  const userCompRes = await runQuery(connectUserCompany(), [userId, companyId]);

  if (!userCompRes) {
    //We don't need to destruct anything out of this, so just make sure we were success
    console.log("failed to connect user to company on registration");
    res.status(500).send({ status: 0 });
    return;
  }

  const token = genToken();

  const { insertId: tokenId } = await runQuery(insertUserToken(), [token]);

  const { insertId: connection } = await runQuery(insertUserTokenConnection(), [
    userId,
    tokenId,
  ]);

  addToken(email, {
    userId,
    token,
    tokenId,
    connection,
  });

  res.send({
    status: 1,
    data: {
      user: { email, token, authenticated: true },
      company: {
        name: company,
        street: companyStreet,
        city: companyCity,
        county: companyCounty,
        postcode: companyPostcode,
        country: companyCountry,
      },
    },
  });
});

router.delete("/logout", async function (req, res) {
  const { token } = req.headers;

  if (!token) {
    res.status(400).send({ status: 0 });
    return;
  }

  const result = await runQuery(
    update("tokens", [["token", "null"]], ["token", `'${token}'`])
  );

  if (!result) {
    res.status(500).send();
    return;
  }

  res.send({ data: "yeet" });
});

router.put("/forgot-password", async function (req, res) {
  const { email } = req.body;

  if (!email) {
    res.status(400).send({ status: 0 });
    return;
  }

  const [user] = await runQuery(select("users", ["id", "email"], "email"), [
    email,
  ]);

  if (!user) {
    //No email was found, however set status to 1 still as we don't want the user knowing if it's a valid email
    res.status({ status: 1 });
    return;
  }

  const token = genToken(50, false);

  const relation = await runQuery(
    select("user_reset", ["token_id"], "user_id"),
    [user.id]
  );

  const created = relation.length
    ? await updateUserResetToken(token, relation)
    : await createUserResetToken(token, user);

  if (!created) {
    res.status(500).send({ status: 0 });
    return;
  }

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

router.patch(
  "/reset-password/:token/:email/:password",
  async function (req, res) {
    const { token, email, password } = req.params;

    if (!token || !email) {
      res.status(400).send({ status: 0 });
      return;
    }

    const [tokenRes] = await runQuery(select("reset_tokens", ["id"], "token"), [
      token,
    ]);

    if (!tokenRes) {
      console.log("token not found, forbidden");
      res.status(403).send({ status: 0 });
      return;
    }

    const [userRes] = await runQuery(select("users", ["id"], "email"), [email]);

    const [relationRes] = await runQuery(
      select("user_reset", ["user_id"], "token_id"),
      [tokenRes.id]
    );

    //Something didn't match up or the token received didn't match the email issued to. So stop here.
    if (
      !tokenRes ||
      !userRes ||
      !relationRes ||
      relationRes?.user_id !== userRes.id
    ) {
      res.send({ status: 0 });
      return;
    }

    const updateRes = await runQuery(
      update("users", [["password"]], ["email"]),
      [sha256(`${process.env.SALT}${password}`), email]
    );

    if (!updateRes) {
      res.status(500).send({ status: 0 });
    }
    res.send({ status: 1 });
  }
);

module.exports = router;
