const { runQuery } = require("../sql");
const queries = require("../../mysql/query");
const generic = require("../../utils/generic");
const { convertDateToUnix, penniesToPounds, poundsToPennies } = require("../../utils/generic");

const utils = {
  validateData: (payload) => {
    //Don't check for price as can be ommitted if free issue

    const {
      sku,
      qty,
      company,
      companyStreet,
      companyCity,
      companyCounty,
      companyCountry,
      companyPostcode,
      locations,
      history,
    } = payload;

    if (
      !sku ||
      !qty ||
      !company ||
      !companyStreet ||
      !companyCity ||
      !companyCounty ||
      !companyCountry ||
      !companyPostcode ||
      !locations ||
      !history
    )
      return false;

    let valid = true;
    for (const his of history) {
      const { qty, locations } = his;
      if (!qty || !locations) {
        valid = false;
        break;
      }
    }

    return valid;
  },

  createStock: async ({ sku, qty, price }) => {
    try {
      const res = await runQuery(queries.stock.insertStock(), [
        sku,
        qty,
        price ? generic.poundsToPennies(price) : 0,
        null,
        !price ? 1 : 0,
      ]);

      if (res instanceof Error) return res;

      return res.insertId;
    } catch (err) {
      return `createStock: ${err}`;
    }
  },

  addItemToUser: async (data, id) => {
    try {
      const { sku, qty, price } = data;

      const valid = await utils.validateUserSku(sku, id);
      if (valid instanceof Error) throw new Error(valid);

      if (!valid) return "used";

      const itemId = await utils.createStock({ sku, qty, price });
      if (itemId instanceof Error) throw new Error(itemId);

      const relation = await runQuery(queries.user.insertRelation("stock", "stock_id"), [
        id,
        itemId,
      ]);

      if (relation instanceof Error) throw new Error(relation);

      return itemId;
    } catch (err) {
      return `addItemToUser: ${err}`;
    }
  },

  selectUserIds: async (id) => {
    try {
      const ids = await runQuery(queries.stock.selectrelationIds(), [id]);
      if (ids instanceof Error) throw new Error(ids);
      return ids;
    } catch (err) {
      return err;
    }
  },

  validateUserSku: async (sku, id) => {
    try {
      const ids = await utils.selectUserIds(id);

      const skus = [];

      for (const { id } of ids) {
        const res = await runQuery(queries.stock.select("sku"), [id]);
        if (res instanceof Error) throw new Error(`validateUserSku: ${res}`);
        skus.push(res[0].sku);
      }

      return skus.every((i) => i.toLowerCase() !== sku.toLowerCase());
    } catch (err) {
      return err;
    }
  },

  createCompanyRelation: async (stock, company) => {
    try {
      const res = await runQuery(queries.stock.insertCompanyRelation(), [stock, company]);
      if (res instanceof Error) throw new Error(`stock creatCompanyRelation: ${res}`);
      return res.insertId;
    } catch (err) {
      return err;
    }
  },

  createLocations: async (locations, id) => {
    try {
      for (const location of locations) {
        const locId = await runQuery(queries.stock.insertLocation(), [
          location.name,
          location.value,
        ]);

        if (locId instanceof Error) throw new Error(`createLocations: ${locId}`);

        const relationship = await runQuery(queries.stock.insertLocationRelation(), [
          id,
          locId.insertId,
        ]);

        if (relationship instanceof Error) throw new Error(`createLocations: ${relationship}`);
      }

      return true;
    } catch (err) {
      return err;
    }
  },

  createHistory: async ([data], itemId) => {
    try {
      const id = await runQuery(queries.stock.insertHistory(), [
        data.sku,
        data.qty,
        generic.poundsToPennies(data.price),
      ]);

      if (id instanceof Error) throw new Error(`createHistory: ${id}`);

      const { insertId: histRelation } = await runQuery(queries.stock.insertHistoryRelation(), [
        itemId,
        id.insertId,
      ]);

      if (histRelation instanceof Error) throw new Error(`createHistory: ${histRelation}`);

      for (const location of data.locations) {
        const locId = await runQuery(queries.stock.insertLocation(), [
          location.name,
          location.value,
        ]);

        if (locId instanceof Error) throw new Error(`createHistory: ${locId}`);

        const relationship = await runQuery(queries.stock.insertHistoryLocRelation(), [
          id.insertId,
          locId.insertId,
        ]);

        if (relationship instanceof Error) throw new Error(`createHistory: ${relationship}`);
      }
      return true;
    } catch (err) {
      return err;
    }
  },

  getLocationIds: async (id) => {
    try {
      const ids = await runQuery(queries.stock.selectLocationRelation(), [id]);
      if (ids instanceof Error) throw new Error(ids);
      return ids;
    } catch (err) {
      return err;
    }
  },

  getLocations: async (id) => {
    try {
      const locations = [];

      const ids = await utils.getLocationIds(id);

      for (const { id } of ids) {
        const location = await runQuery(queries.stock.selectLocation(), [id]);
        if (location instanceof Error) throw new Error(location);

        locations.push({
          id,
          name: location[0].name,
          value: location[0].value,
        });
      }

      return locations;
    } catch (err) {
      return err;
    }
  },

  getHistory: async (id) => {
    const history = [];
    const historyIds = await runQuery(select("stock_histories", ["history_id AS id"], "stock_id"), [
      id,
    ]);

    for (const hisId of historyIds) {
      const { id } = hisId;
      const [history] = await runQuery(
        select("history", ["quantity", "price", "UNIX_TIMESTAMP(date_added) AS dateAdded"], "id"),
        [id]
      );

      const entry = { ...history };
      entry.location = [];

      const hisLocId = await runQuery(
        select("history_locations", ["location_id AS id"], "history_id"),
        [id]
      );

      for (const index of hisLocId) {
        const { id } = index;

        const [currentLoc] = await runQuery(select("locations", ["name", "value"], "id"), [id]);
        entry.location.push({ ...currentLoc });
      }

      history.push(entry);
    }

    return history;
  },

  getStock: async (user, locations, history, id) => {
    try {
      let ids = !id ? await utils.selectUserIds(user) : [id];
      ids = !id ? ids.map((i) => i.id) : ids;

      const data = [];

      for (const id of ids) {
        const stock = await runQuery(queries.stock.select("*"), [id]);
        if (stock instanceof Error) throw new Error(stock);

        stock[0].date = convertDateToUnix(stock[0].date);

        stock[0].price = penniesToPounds(stock[0].price);

        stock[0].locations = locations ? await utils.getLocations(id) : null;
        if (stock[0].locations instanceof Error) throw new Error(stock[0].locations);

        stock[0].history = history ? await utils.getHistory(id) : null;
        if (stock[0].history instanceof Error) throw new Error(stock[0].history);

        data.push({ ...stock[0] });
      }

      return data;
    } catch (err) {
      return err;
    }
  },

  createHistory: async (history) => {
    try {
      const hist = await runQuery(queries.stock.insertHistory(), [
        history.sku,
        history.quantity,
        history.price,
      ]);
      if (hist instanceof Error) throw new Error(`createHistory: ${hist}`);

      const relation = await runQuery(queries.stock.insertHistoryRelation(), [
        history.id,
        hist.insertId,
      ]);
      if (relation instanceof Error) throw new Error(`createHistory: ${relation}`);

      for (const location of history.locations) {
        const res = await runQuery(queries.stock.insertHistoryLocRelation(), [
          hist.insertId,
          location.id,
        ]);
        if (!res instanceof Error) throw new Error(res);
      }

      return true;
    } catch (err) {
      return err;
    }
  },

  patchItem: async (user, data, history, locations) => {
    try {
      const currentSku = await runQuery(queries.stock.select("sku"), [data.id]);
      if (currentSku instanceof Error) throw new Error(`patchItem: ${currentSku}`);

      if (currentSku[0].sku !== data.sku) {
        //Sku has changed, so check if it's unique
        const isValid = await utils.validateUserSku(data.sku, user);
        if (!isValid) return false;
      }

      const update = await runQuery(
        queries.stock.patchStock(["sku", "quantity", "price", "image_name", "free_issue"]),
        [data.sku, data.qty, generic.poundsToPennies(data.price), "null", 0, data.id]
      );
      if (update instanceof Error) throw new Error(`patchItem: ${update}`);

      const hist = await utils.createHistory(history);
      if (hist instanceof Error) throw new Error(`patchItem: ${hist}`);

      return true;
    } catch (err) {
      return err;
    }
  },
};

module.exports = utils;
