const queries = {
  user: {
    relations: {
      stock: "user_stock",
      company: "user_compamy",
      invoices: "user_invoices",
      reset: "user_reset",
      token: "user_token",
    },
    insert: () => `INSERT INTO users (email, password) VALUES (?, ?)`,

    insertRelation: (table, column) => {
      //I really should have used normal functions so I can use 'this'
      return `INSERT INTO ${queries.user.relations[table]} (user_id, ${column}) VALUES (?, ?)`;
    },

    selectCreds: (creds, like) => `SELECT ${creds.join(", ")} FROM users WHERE ${like} LIKE ?;`,

    patch: (target) => {
      return `UPDATE users SET ${target} = ? WHERE id = ?`;
    },
  },

  stock: {
    insertStock: () =>
      `INSERT INTO stock (sku, quantity, price, image_name, free_issue) VALUES (?, ?, ?, ?, ?)`,

    deleteStock: () =>
      `DELETE user_stock, stock, stock_locations, stock_company
        FROM user_stock
          INNER JOIN stock ON user_stock.stock_id = stock.id 
            INNER JOIN stock_locations ON user_stock.stock_id  = stock_locations.stock_id
              INNER JOIN stock_company ON user_stock.stock_id  = stock_company.stock_id
                WHERE user_stock.stock_id = ?`,

    patchStock: (columns) =>
      `UPDATE stock SET ${columns.map((column) => `${column} = ?`).join(", ")} WHERE id = ? `,

    insertHistory: () => `INSERT INTO history (sku, quantity, price) VALUES (?, ?, ?)`,

    insertHistoryRelation: () => `INSERT INTO stock_histories (stock_id, history_id) VALUES (?, ?)`,

    insertHistoryLocRelation: () =>
      `INSERT INTO history_locations (history_id, location_id) VALUES (?, ?)`,

    insertCompanyRelation: () => `INSERT INTO stock_company (stock_id, company_id) VALUES (?, ?)`,

    insertLocation: () => `INSERT INTO locations (name, value) VALUES (?, ?)`,

    insertLocationRelation: () =>
      `INSERT INTO stock_locations (stock_id, location_id) VALUES (?, ?)`,

    selectrelationIds: () => `SELECT stock_id AS id FROM user_stock WHERE user_id = ? `,

    select: (selector) => `SELECT ${selector} FROM stock WHERE id = ? `,

    selectLocation: () => `SELECT name, value FROM locations WHERE id =?`,

    selectLocationId: () => `SELECT id FROM locations WHERE name = ? AND value = ?`,

    selectHistoryIds: () => `SELECT history_id AS id from stock_histories where stock_id = ?`,

    selectHistory: () =>
      `SELECT id, quantity, price, UNIX_TIMESTAMP(date_added) AS dateAdded FROM history WHERE id = ?`,

    selectHistoryLocationRelation: () =>
      `SELECT location_id AS id FROM history_locations where history_id = ?`,

    selectLocationRelation: () =>
      `SELECT location_id as id FROM stock_locations where stock_id = ?`,

    deleteLocationRelation: () =>
      `DELETE FROM stock_locations WHERE location_id = ? AND stock_id = ?`,

    deleteHistoryRelation: () => `DELETE FROM stock_histories WHERE history_id = ?;`,

    deleteHistory: () => `DELETE FROM history WHERE id = ?;`,
    deleteHistoryLocationRelation: () => `DELETE FROM history_locations WHERE history_id = ?;`,
  },
  company: {
    select: () => `SELECT * FROM companies WHERE name = ? AND postcode = ?`,

    insert: () =>
      `INSERT INTO companies (name, address, city, county, postcode, country) VALUES (?, ?, ?, ?, ?, ?);`,

    insertUserCompanyRelation: () => `INSERT INTO user_company (user_id, company_id) VALUES (?, ?)`,

    selectUserCompany: () =>
      `SELECT user_company.company_id,
      companies.name, companies.address, companies.city, companies.county, companies.postcode, companies.country
      FROM user_company
        JOIN companies ON companies.id = user_company.company_id
          WHERE user_company.user_id = ?`,

    insertInvoiceCompanyRelation: () =>
      `INSERT INTO user_invoices (user_id, invoice_id) VALUES (?, ?)`,
  },
  invoices: {
    insertCompany: () =>
      `INSERT INTO invoice_company (contact, name, address, city, state, country, postcode) VALUES (?,?,?,?,?,?,?)`,

    selectCompany: () => `SELECT id FROM invoice_company WHERE name = ? AND postcode = ?`,

    insertUserRelation: () => `INSERT INTO user_invoices (user_id, invoice_id) VALUES (?, ?)`,

    insertSpecifics: () =>
      `INSERT INTO invoice_specifics (due_date, billing_date, order_number, footer) VALUES (?, ?, ?, ?);`,

    insertSpecificRelation: () =>
      `INSERT INTO invoice_specific (invoice_id, specific_id) VALUES (?, ?)`,

    insertItem: () =>
      `INSERT INTO invoice_items (sku, description, quantity, price, tax) VALUES (?, ?, ?, ?, ?)`,

    insertItemRelation: () => `INSERT INTO invoice_item (invoice_id, item_id) VALUES (?, ?)`,

    select: () =>
      `SELECT 
        invoice_company.id, invoice_company.contact, invoice_company.name, invoice_company.address, invoice_company.city, invoice_company.state, invoice_company.country, invoice_company.postcode,
        invoice_specific.specific_id AS specificId,
        invoice_specifics.billing_date AS billingDate, invoice_specifics.due_date AS dueDate, invoice_specifics.order_number AS orderNumber, invoice_specifics.footer
          FROM invoice_company
            JOIN invoice_specific ON  invoice_specific.invoice_id = ?
            JOIN invoice_specifics ON invoice_specifics.id = invoice_specific.specific_id 
              WHERE invoice_company.id = ?;`,

    selectIds: () => `SELECT invoice_id AS id FROM user_invoices WHERE user_id = ?`,

    selectItemIds: () => `SELECT item_id AS id FROM invoice_item WHERE invoice_id = ?`,

    selectItem: () =>
      `SELECT sku, description, quantity, price, tax FROM invoice_items WHERE id = ?`,
  },

  tokens: {
    select: () => `SELECT user_token.token_id AS id, tokens.token AS value
                    FROM user_token 
                      JOIN tokens ON tokens.id = user_token.token_id 
                        WHERE user_token.user_id = ?`,

    insert: () => `INSERT INTO tokens (token) VALUES(?);`,

    insertRelation: () => `INSERT INTO user_token (user_id, token_id) VALUES (?, ?);`,

    patch: () => `UPDATE tokens SET token = ? WHERE id = ?`,

    insertResetToken: () => `INSERT INTO reset_tokens (token) VALUES (?)`,

    insertResetRelation: () => `INSERT INTO user_reset (user_id, token_id) VALUES (?, ?)`,

    selectResetRelation: () => `SELECT token_id AS value FROM user_reset WHERE user_id = ?`,

    patchResetToken: () => `UPDATE reset_tokens SET token = ? WHERE id = ?`,

    selectResetId: () => `SELECT id FROM reset_tokens WHERE token = ?`,

    selectResetEmail: () => {
      return `SELECT 
              user_reset.user_id AS id, 
              users.email
                FROM user_reset 
                  JOIN users ON user_reset.user_id = users.id
                    WHERE token_id = ?`;
    },
  },

  initCache: () => `SELECT id, email FROM users`,

  select: (location, targets, selector) => {
    return `SELECT ${targets.join(", ")} FROM ${location} ${
      selector &&
      `WHERE ${
        typeof selector === "string"
          ? `${selector} = ?`
          : selector
              .map((select, index) => `${select} = ? ${index === selector.length - 1 ? "" : "AND"}`)
              .join(" ")
      }`
    }`;
  },

  insert: (location, columns) =>
    `INSERT INTO ${location} (${columns.join(", ")}) VALUES (${columns.map(() => "?")})`,

  //This makes me cry
  update: (location, targets, selector) => {
    return `UPDATE ${location} SET 
              ${targets.map(
                (target) =>
                  //Set to value received or ? for prepped statement
                  `\`${target[0]}\` = ${target[1] ? target[1] : "?"}${
                    // Do we have mulktiple updates? If so add , else ''
                    targets.length > 1 ? ", " : ""
                  }`
              )} 
                WHERE ${selector[0]} = ${selector[1] ? selector[1] : "?"}`;
  },

  remove: (table, selector) => {
    return `DELETE FROM ${table} WHERE ${selector} = ?`;
  },
};

module.exports = queries;
