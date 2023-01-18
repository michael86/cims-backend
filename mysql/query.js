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

  initCache: () => {
    return `SELECT id, email FROM users`;
  },

  select: (location, targets, selector) => {
    return `SELECT ${targets.join(", ")} FROM ${location} ${
      selector && `WHERE ${selector} LIKE ?`
    }`;
  },

  //This makes me cry
  update: (location, targets, selector) => {
    return `UPDATE ${location} SET 
              ${targets.map(
                (target) =>
                  `${target[0]} = ${target[1]}${targets.length > 1 ? ", " : ""}`
              )} 
                WHERE ${selector[0]} = ${selector[1]}`;
  },

  deleteFrom: (location, [key, value]) => {
    console.log(key, value);
  },
};

module.exports = queries;
