const queries = {
  createUser: () => {
    return `INSERT INTO users 
                (email, password)
                     VALUES
                        (?, ?);`;
  },

  checkCreds: () => {
    return `SELECT id FROM users WHERE 
            email LIKE ?
            AND 
            password LIKE ?;`;
  },

  addToken: (user_id, token) => {
    return `INSERT INTO logins
                    (user_id, token)
                            VALUES
                                (${user_id}, "${token}");`;
  },

  removeToken: (token) => {
    return `DELETE FROM logins
                WHERE token = "${token}";`;
  },

  getUser: (token) => {
    return `SELECT name, email, users.entry_date FROM users
              JOIN logins
                ON users.id = logins.user_id`;
    //WHERE token = "${token}";`;
  },

  deleteUser: (token) => {
    return `DELETE users FROM users
              JOIN logins
                ON users.id = logins.user_id
                  WHERE token = "${token}";`;
  },

  updateUser: (token, column, value) => {
    return `UPDATE users
              JOIN logins
                ON users.id = logins.user_id
                  SET ${column} = "${value}"
                    WHERE token = "${token}";`;
  },

  checkToken: (token) => {
    return `SELECT users.id
                FROM users 
                  JOIN logins
                    ON users.id = logins.user_id
                      WHERE token = "${token}";`;
  },
};

module.exports = queries;
