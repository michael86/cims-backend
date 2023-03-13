require("dotenv").config();
const SibApiV3Sdk = require("sib-api-v3-sdk");
SibApiV3Sdk.ApiClient.instance.authentications["api-key"].apiKey =
  process.env.SEND_IN_BLUE;

module.exports.sendEmail = async (payload) => {
  const { receivers, subject, htmlContent, params } = payload;

  //project_directory/emailBuilder.js

  const receiptants = receivers.map((email) => {
    return { name: "John Doe", email };
  });

  const mail = new SibApiV3Sdk.TransactionalEmailsApi();
  const result = await mail.sendTransacEmail({
    subject: subject,
    sender: { email: "support@cims.co.uk", name: "Support" },
    replyTo: { email: "do-not-reply@cims.co.uk", name: "do-not-reply" },
    to: receiptants,
    htmlContent,
    params,
  });
  if (!result.messageId) {
    console.log("error sending mail", result);
    return false;
    1;
  }
  return true;
};
