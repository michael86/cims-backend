const express = require("express");
const router = express.Router();
const path = require("node:path");
const fs = require("fs");

router.get("/pdf/:filename/:token?", async function (req, res) {
  const { filename } = req.params;

  const filePath = path.join(__dirname, "..", "public/invoices", filename);

  try {
    if (fs.existsSync(filePath)) {
      res.setHeader("Content-disposition", "attachment; filename=jsonFile.json");
      res.setHeader("Content-Type", "text/json");
      res.download(filePath, function (err) {
        if (err) {
          console.log(err);
        }

        fs.unlink(filePath, (err) => console.log("deleted", filePath));
      });
    }
  } catch (err) {
    console.error(err);
  }
});

module.exports = router;
