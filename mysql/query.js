const queries = {
  user: {
    insert: () => `INSERT INTO users (email, password) VALUES (?, ?)`,

    selectCreds: (creds, like) => `SELECT ${creds.join(", ")} FROM users WHERE ${like} LIKE ?;`,

    patch: (target) => {
      return `UPDATE users SET ${target} = ? WHERE id = ?`;
    },
  },

  stock: {
    insertStock: () => {
      return `INSERT INTO stock (sku, description, quantity, price, tax) VALUES (?, ?, ?, ?, ?)`;
    },

    patchStock: (items, selectors) => {
      return `UPDATE stock SET ${items
        .map((item, index) => `${item} = ?${index !== items.length - 1 ? "," : ""} `)
        .join("")} 
            WHERE  ${selectors.map((selector) => `${selector} = ?`)}`;
    },
    insertHistory: () => {
      return `INSERT INTO history (sku, quantity, price) VALUES (?, ?, ?)`;
    },

    createHistoryRelation: () => {
      return `INSERT INTO stock_histories (stock_id, history_id) VALUES (?, ?)`;
    },
    createHistoryLocRelation: () => {
      return `INSERT INTO history_locations (history_id, location_id) VALUES (?, ?)`;
    },
  },
  company: {
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
    selectInvoiceIds: (userId) =>
      `SELECT invoice_id FROM user_invoices WHERE user_invoices.user_id LIKE ${userId}`,

    insertInvoiceSpecifics: () =>
      `INSERT INTO invoice_specifics (due_date, billing_date, order_number, footer) VALUES (?, ?, ?, ?);`,

    insertInvoiceItems: () =>
      `INSERT INTO invoice_items (sku, description, quantity, price, tax) VALUES (?, ?, ?, ?, ?)`,

    selectInvoice: () =>
      `SELECT 
        invoice_company.contact, invoice_company.name, invoice_company.address, invoice_company.city, invoice_company.state, invoice_company.country, invoice_company.postcode,
        invoice_specific.specific_id,
        invoice_specifics.billing_date, invoice_specifics.due_date, invoice_specifics.order_number, invoice_specifics.footer
          FROM invoice_company
            JOIN invoice_specific ON  invoice_specific.invoice_id = ?
            JOIN invoice_specifics ON invoice_specifics.id = invoice_specific.specific_id 
              WHERE invoice_company.id = ?;`,

    selectInvoiceItemIds: () => `SELECT item_id FROM invoice_item WHERE invoice_id = ?`,
  },

  tokens: {
    insert: () => `INSERT INTO tokens (token) VALUES(?);`,

    insertRelation: () => `INSERT INTO user_token (user, token) VALUES (?, ?);`,

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
