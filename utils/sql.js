const asyncMySQL = require("../mysql/connection");
const { update, insert } = require("../mysql/query");

module.exports.runQuery = async (query, data) => {
  try {
    const res = await asyncMySQL(query, data);

    if (res.affectedRows === 0) {
      console.log("runQuery error", res);
      return;
    }

    return res;
  } catch (err) {
    // console.error("sql error", err);
    if (err.code) return err.code;
  }
};

module.exports.updateToken = async (location, values, target) => {
  try {
    const { affectedRows } = await this.runQuery(
      update(location, values, target)
    );

    if (!affectedRows) {
      return;
    }

    return true;
  } catch (err) {
    console.error("auth error", err);
    res.status({ status: 500 }).send({ status: 0 });
  }
};

module.exports.createUserResetToken = async (token, user) => {
  const tokenRes = await this.runQuery(insert("reset_tokens", ["token"]), [
    token,
  ]);

  const relationship = await this.runQuery(
    insert("user_reset", ["user_id", "token_id"]),
    [user.id, tokenRes.insertId]
  );

  return relationship.insertId ? true : false;
};

module.exports.updateUserResetToken = async (token, [relation]) => {
  const tokenRes = await this.runQuery(
    update("reset_tokens", [["token"]], ["id"]),
    [token, relation.token_id]
  );

  return tokenRes.affectedRows ? true : false;
};
