const asyncMySQL = require("../mysql/connection");
const { update } = require("../mysql/query");

module.exports.runQuery = async (query, data) => {
  try {
    const res = await asyncMySQL(query, data);

    if (res.affectedRows === 0) {
      console.log("runQuery", res);
      return;
    }

    return res;
  } catch (err) {
    console.error(err);
  }
};

module.exports.updateToken = async (location, values, target) => {
  try {
    const { affectedRows } = await this.runQuery(
      update(location, values, target)
    );

    console.log("affected", affectedRows);

    if (!affectedRows) {
      return;
    }

    return true;
  } catch (err) {
    console.log("auth error", err);
    res.status({ status: 500 }).send({ status: 0 });
  }
};
