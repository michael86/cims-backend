const express = require("express");
const router = express.Router();
const path = require("node:path");
const fs = require("fs");

router.get("/pdf/:id", async function (req, res) {
  const { id } = req.params;

  const filePath = path.join(__dirname, "..", "public/invoices", id);
  try {
    if (fs.existsSync(filePath)) {
      console.log(`exists ${filePath}`);
      res.setHeader(
        "Content-disposition",
        "attachment; filename=jsonFile.json"
      );
      res.setHeader("Content-Type", "text/json");
      res.download(filePath, function (err) {
        if (err) {
          console.log(err);
        }
      });
    }
  } catch (err) {
    console.error(err);
  }
});

module.exports = router;
