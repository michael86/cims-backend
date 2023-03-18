const asyncMySQL = require("../../mysql/connection");
const { update } = require("../../mysql/query");

module.exports.runQuery = async (query, data) => {
  try {
    for (const i in data) if (typeof data[i] === "string") data[i] = data[i].toLowerCase();

    const res = await asyncMySQL(query, data);

    if (res.affectedRows === 0) {
      console.log("runQuery error", res);
      return;
    }

    return res;
  } catch (err) {
    if (err.code) return err.code;
  }
};

module.exports.updateToken = async (location, values, target) => {
  try {
    const { affectedRows } = await this.runQuery(update(location, values, target));

    if (!affectedRows) {
      return;
    }

    return true;
  } catch (err) {
    console.error("auth error", err);
    res.status({ status: 500 }).send({ status: 0 });
  }
};
