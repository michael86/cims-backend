require("dotenv").config();

const SibApiV3Sdk = require("sib-api-v3-sdk");
const defaultClient = SibApiV3Sdk.ApiClient.instance;
// # Instantiate the client\
const apiKey = defaultClient.authentications["api-key"];
apiKey.apiKey = process.env.sendinblue;
const apiInstance = new SibApiV3Sdk.EmailCampaignsApi();
const emailCampaigns = new SibApiV3Sdk.CreateEmailCampaign();

// # Define the campaign settings\
emailCampaigns.name = "Support";
emailCampaigns.subject = "forgot password";
emailCampaigns.sender = { name: "support", email: "support@cims.co.uk" };
emailCampaigns.type = "classic";

// # Content that will be sent\
// htmlContent: 'Congratulations! You successfully sent this example campaign via the Sendinblue API.',
// # Select the recipients\
// recipients: {listIds: [2, 7]},
// # Schedule the sending in one hour\
// scheduledAt: '2018-01-01 00:00:01'
// }
// # Make the call to the client\

apiInstance.createEmailCampaign(emailCampaigns).then(
  function (data) {
    console.log("API called successfully. Returned data: " + data);
  },
  function (error) {
    console.error(error);
  }
);
