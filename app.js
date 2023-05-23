const express = require("express");
const { validateToken, initTokenCache } = require("./middleware/tokens");
const app = express();
const cors = require("cors");
const { initStockCache } = require("./cache/stock.js");

require("dotenv").config();

app.use(express.json());
app.use(express.static("./public"));
app.use(cors());

app.use("/account", validateToken, require("./routes/account"));
app.use("/auth", validateToken, require("./routes/auth"));
app.use("/invoice", validateToken, require("./routes/invoices"));
app.use("/stock", validateToken, require("./routes/stock"));
app.use("/download", require("./routes/download"));

initTokenCache().then(() => {
  initStockCache().then(() => {
    const port = process.env.PORT || 6005;
    app.listen(6005, async () => {
      console.log(`listening port ${port}\nServer started`);
    });
  });
});
