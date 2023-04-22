const { runQuery } = require("../utils/sql");
const { penniesToPounds } = require("../utils/generic");

let stock, users, userStock, locations, stockLocations, history, stockHistory, historyLocation;
const cache = [];

const populate = async () => {
  stock = await runQuery("SELECT *, UNIX_TIMESTAMP(date_created) as date FROM stock");

  users = await runQuery("SELECT * FROM users");
  userStock = await runQuery("SELECT * FROM user_stock");

  locations = await runQuery("SELECT * FROM locations");
  stockLocations = await runQuery("SELECT * FROM stock_locations");

  history = await runQuery("SELECT *, UNIX_TIMESTAMP(date_added) as date FROM history");
  stockHistory = await runQuery("SELECT * FROM stock_histories");
  historyLocation = await runQuery("SELECT * FROM history_locations");
};

const getStockRelations = (user) => {
  const data = [];

  for (const entry of userStock) if (user === entry.user_id) data.push(entry.stock_id);

  return data;
};

const getLocationRelation = (id) => {
  const data = [];

  for (const entry of stockLocations) {
    if (entry.stock_id === id) {
      data.push(entry.location_id);
    }
  }

  return data;
};

const getItemLocations = (id) => {
  const data = [];
  const relations = getLocationRelation(id);
  for (const relation of relations) {
    for (const location of locations) {
      if (location.id === relation) {
        data.push({ ...location });
      }
    }
  }
  return data;
};

const getHistoryRelations = (id) => {
  const data = [];
  for (const relation of stockHistory) {
    if (relation.stock_id === id) data.push(relation.history_id);
  }

  return data;
};

const getHistoryLocationsRelations = (id) => {
  const data = [];
  for (const relation of historyLocation) {
    if (relation.history_id === id) data.push(relation.location_id);
  }
  return data;
};

const getHistoryLocations = (id) => {
  const relations = getHistoryLocationsRelations(id);
  const data = [];
  for (const relation of relations) {
    for (const location of locations) {
      if (location.id === relation) {
        data.push({ ...location });
      }
    }
  }

  return data;
};

const getItemHistory = (id) => {
  const relations = getHistoryRelations(id);
  const data = [];
  for (const entry of history) {
    if (relations.includes(entry.id)) {
      entry.locations = getHistoryLocations(entry.id);

      data.push({ ...entry });
    }
  }
  return data;
};

const getUserStock = (user) => {
  const data = [];

  for (const relation of userStock)
    for (const item of stock) {
      if (item.id === relation.stock_id) {
        item.locations = getItemLocations(item.id);
        item.history = getItemHistory(item.id);
        item.price = penniesToPounds(item.price);
        data.push({ ...item });
      }
    }

  return data;
};

module.exports.initStockCache = async () => {
  console.log("initiating stock cache...\nThis may take a while based on database size");

  try {
    await populate();

    for (const { id: user } of users) {
      const relations = getStockRelations(user);

      cache[user] = getUserStock(stock, relations);
    }
  } catch (err) {
    console.log(err);
  }
};

module.exports.getUserData = (id) => (cache[id] ? cache[id] : null);
