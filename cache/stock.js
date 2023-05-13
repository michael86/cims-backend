const { runQuery } = require("../utils/sql");
const { penniesToPounds, poundsToPennies } = require("../utils/generic");

let stock, users, userStock, locations, stockLocations, history, stockHistory, historyLocation;
const cache = [];

const populate = async () => {
  stock = await runQuery("SELECT *, UNIX_TIMESTAMP(date_created) as date_created FROM stock");

  users = await runQuery("SELECT * FROM users");
  userStock = await runQuery("SELECT * FROM user_stock");

  locations = await runQuery("SELECT * FROM locations");
  stockLocations = await runQuery("SELECT * FROM stock_locations");

  history = await runQuery("SELECT *, UNIX_TIMESTAMP(date_added) as date_added FROM history");
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
    entry.price = entry.price % 1 === 0 ? entry.price : penniesToPounds(entry.price);
    if (relations.includes(entry.id)) {
      entry.locations = getHistoryLocations(entry.id);

      data.push({ ...entry });
    }
  }
  return data;
};

const getUserStock = () => {
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
    console.log("selecting all stock");
    await populate();

    for (const { id: user } of users) {
      console.log(`creating stock for user ${user}`);
      const relations = getStockRelations(user);

      cache[user] = getUserStock(stock, relations);
    }
  } catch (err) {
    console.log(err);
  }
};

module.exports.addStockCache = (data, user) => {
  cache[user].push(data);
  return cache[user];
};

module.exports.patchStockCache = (user, data, history) => {
  const skuId = data.id;

  const index = cache[user].findIndex((entry) => entry.id === skuId);
  if (index < 0) return new Error("Invalid sku id");

  const entry = cache[user][index];
  entry.sku = data.sku;
  entry.quantity = data.quantity;
  entry.price = data.price;
  entry.locations = data.locations;
  entry.history.push({
    sku: history.sku,
    quantity: +history.quantity,
    price: poundsToPennies(history.price),
    date_added: Math.floor(new Date() / 1000), //reflect database unix timestamp
    locations: history.locations,
  });

  cache[user][index] = entry;

  return cache[user];
};

module.exports.deleteStockCache = (user, id) => {
  const index = cache[user].findIndex((entry) => +entry.id === +id);
  delete cache[user][index];

  return cache[user];
};

module.exports.getUserData = (id) => (cache[id] ? cache[id] : null);
