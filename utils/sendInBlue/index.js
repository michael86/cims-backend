require("dotenv").config();
const SibApiV3Sdk = require("sib-api-v3-sdk");
const { forgotPassword } = require("../../emails/forgot-password");

SibApiV3Sdk.ApiClient.instance.authentications["api-key"].apiKey = process.env.SEND_IN_BLUE;
const utils = {
  sendEmail: async (payload) => {
    try {
      const { receivers, subject, htmlContent, params } = payload;

      const receiptants = receivers.map((email) => {
        return { name: "sir/madame", email };
      });

      const mail = new SibApiV3Sdk.TransactionalEmailsApi();

      const result = await mail.sendTransacEmail({
        subject: subject,
        sender: { email: "support@cims.co.uk", name: "Support @ cims" },
        replyTo: { email: "do-not-reply@cims.co.uk", name: "do-not-reply" },
        to: receiptants,
        htmlContent,
        params,
      });

      if (!result.messageId) throw new Error("error sending mail");

      return true;
    } catch (err) {
      console.log(`error sendMail \n payload: ${payload} \n error: ${err}`);
      return;
    }
  },

  sendResetPassEmail: async (token, email, res) => {
    try {
      const params = {
        route: `${process.env.ROOT}/reset-password?token=${token}&email=${email}`,
      };

      const emailSent = await utils.sendEmail({
        receivers: [email],
        subject: "forgotPassword",
        htmlContent: forgotPassword,
        params,
      });

      if (!emailSent) {
        //Send 1, to make malicious user think email sent
        res.send({ status: 1 });
        throw new Error("failed to send email");
      }
    } catch (err) {
      console.log(`Error sending reset password \n token: ${token} \n email: ${email} \n ${err}`);
      return;
    }
  },
};

module.exports = utils;
