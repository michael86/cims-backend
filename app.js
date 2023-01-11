const express = require("express");
const { authenticate } = require("./middleware/tokens");
const app = express();
const cors = require("cors");

require("dotenv").config();

app.use(express.json()); //Turn body into json
app.use(express.static("public")); //Handle static files.
app.use(cors());
app.use("/register", require("./routes/register"));
app.use("/login", authenticate, require("./routes/login"));

const port = process.env.PORT || 6005;

app.listen(6005, () => console.log(`listening port ${port}`));
