const express = require("express");
const { authenticate, validateToken } = require("./middleware/tokens");
const app = express();
const cors = require("cors");

require("dotenv").config();

app.use(express.json()); //Turn body into json
app.use(express.static("public")); //Handle static files.
app.use(cors());

app.use("/account", require("./routes/account"));
app.use("/auth", validateToken, require("./routes/auth"));

const port = process.env.PORT || 6005;

app.listen(6005, () => console.log(`listening port ${port}`));
