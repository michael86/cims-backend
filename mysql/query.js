const queries = {
  createUser: () => {
    return `INSERT INTO users 
                (email, password)
                     VALUES
                        (?, ?);`;
  },

  createCompany: () => {
    return `INSERT INTO companies (name, address, city, county, postcode, country) 
            VALUES (?, ?, ?, ?, ?, ?);`;
  },

  connectUserCompany: () => {
    return `INSERT INTO user_company (user_id, company_id) 
            VALUES (?, ?);`;
  },

  getUserCreds: (creds, like) => {
    return `SELECT ${creds.join(", ")} FROM users WHERE 
            ${like} LIKE ?;`;
  },

  insertUserToken: () => {
    return `INSERT INTO tokens (token) VALUES(?);`;
  },

  insertUserTokenConnection: () => {
    return `INSERT INTO user_token (user, token) VALUES (?, ?);`;
  },
};

module.exports = queries;
