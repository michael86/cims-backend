const express = require("express");
const {
  authenticate,
  validateToken,
  initTokenCache,
} = require("./middleware/tokens");
const app = express();
const cors = require("cors");

require("dotenv").config();

app.use(express.json()); //Turn body into json
app.use(express.static("public")); //Handle static files.
app.use(cors());

app.use("/account", require("./routes/account"));
app.use("/auth", validateToken, require("./routes/auth"));
app.use("/invoice", validateToken, require("./routes/invoices"));

//This works, however, as we redirect the user to a protected route on registration the auth route needs to store the new tokend
initTokenCache().then(() => {
  const port = process.env.PORT || 6005;
  app.listen(6005, async () => {
    console.log(`listening port ${port}`);
  });
});
