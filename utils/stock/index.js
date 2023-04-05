const { runQuery } = require("../sql");
const queries = require("../../mysql/query");
const generic = require("../../utils/generic");
const { convertDateToUnix, penniesToPounds } = require("../../utils/generic");

const utils = {
  validateData: (payload) => {
    //Don't check for price as can be ommitted if free issue

    const {
      sku,
      quantity,
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
      !quantity ||
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

    const { quantity: q, locations: l } = history[0];

    if (!q || !l) valid = false;

    return valid;
  },

  createStock: async ({ sku, quantity, price }) => {
    try {
      const res = await runQuery(queries.stock.insertStock(), [
        sku,
        quantity,
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

  deleteStock: async (id) => {
    try {
      const res = await runQuery(queries.stock.deleteStock(), [id]);
      if (res instanceof Error) throw new Error(`deleteStock: ${res}`);

      return res.affectedRows;
    } catch (err) {
      return err;
    }
  },

  deleteHistory: async (id) => {
    try {
      const historyIds = await runQuery(queries.stock.selectHistoryIds(), [id]);

      if (historyIds instanceof Error) throw new Error(`deleteHistory: ${historyIds}`);

      for (const { id } of historyIds) {
        const relation = await runQuery(queries.stock.deleteHistoryRelation(), [id]);
        if (relation instanceof Error) throw new Error(`deleteHistory #relation: ${relation}`);

        const history = await runQuery(queries.stock.deleteHistory(), [id]);
        if (history instanceof Error) throw new Error(`deleteHistory #history: ${history}`);

        const location = await runQuery(queries.stock.deleteHistoryLocationRelation(), [id]);
        if (location instanceof Error) throw new Error(`deleteHistory #location: ${location}`);
      }

      return true;
    } catch (err) {
      return err;
    }
  },

  addItemToUser: async (data, id) => {
    try {
      const { sku, quantity, price } = data;

      const valid = await utils.validateUserSku(sku, id);
      if (valid instanceof Error) throw new Error(valid);

      if (!valid) return "used";

      const itemId = await utils.createStock({ sku, quantity, price });
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

  createLocations: async (locations) => {
    try {
      const ids = [];
      for (const location of locations) {
        let res = await runQuery(queries.stock.insertLocation(), [location.name, location.value]);

        if (res instanceof Error) throw new Error(`createLocations: ${res}`);

        if (res === "ER_DUP_ENTRY") {
          res = await runQuery(queries.stock.selectLocationId(), [location.name, location.value]);
        }

        ids.push(res.insertId || res[0].id);
      }

      return ids;
    } catch (err) {
      return err;
    }
  },

  createLocationRelations: async (locations, stock, history = false) => {
    try {
      const ids = [];
      for (const location of locations) {
        const res = await runQuery(
          !history
            ? queries.stock.insertLocationRelation()
            : queries.stock.insertHistoryLocRelation(),
          [stock, location]
        );

        if (res instanceof Error) throw new Error(`createLocationrelation: ${relationship}`);
        ids.push(res.insertId);
      }

      return ids;
    } catch (err) {
      return err;
    }
  },

  createHistory: async (data, stockId) => {
    try {
      const id = await runQuery(queries.stock.insertHistory(), [
        data.sku,
        data.quantity,
        generic.poundsToPennies(data.price),
      ]);

      if (id instanceof Error) throw new Error(`createHistory: ${id}`);

      const relation = await runQuery(queries.stock.insertHistoryRelation(), [
        data.id || stockId,
        id.insertId,
      ]);

      if (relation instanceof Error) throw new Error(`createHistory: ${relation}`);

      const locationIds = await utils.createLocations(data.locations);
      if (locationIds instanceof Error) throw new Error(`createHistory: ${locationIds}`);

      const locRelations = await utils.createLocationRelations(locationIds, id.insertId, true);
      if (locRelations instanceof Error) throw new Error(`createHistory: ${locRelations}`);

      return true;
    } catch (err) {
      return err;
    }
  },

  getLocationIds: async (id, history = false) => {
    try {
      const ids = await runQuery(
        history
          ? queries.stock.selectHistoryLocationRelation()
          : queries.stock.selectLocationRelation(),
        [id]
      );

      if (ids instanceof Error) throw new Error(ids);
      return ids;
    } catch (err) {
      return err;
    }
  },

  getLocations: async (id, history = false) => {
    try {
      const locations = [];

      const ids = await utils.getLocationIds(id, history);
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
    try {
      const history = [];

      const historyIds = await runQuery(queries.stock.selectHistoryIds(), [id]);
      if (historyIds instanceof Error) throw new Error(`stock/getHistory: ${historyIds}`);

      for (const { id } of historyIds) {
        const history = await runQuery(queries.stock.selectHistory(), [id]);
        if (history instanceof Error) throw new Error(`stock/getHistory: ${history}`);
        const entry = { ...history[0] };

        entry.locations = await utils.getLocations(id, true);

        history.push(entry);
      }

      return history;
    } catch (err) {
      console.log(err);
    }
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

        stock[0].locations = locations && (await utils.getLocations(id));
        if (stock[0].locations instanceof Error) throw new Error(stock[0].locations);

        stock[0].history = history && (await utils.getHistory(id));
        if (stock[0].history instanceof Error) throw new Error(stock[0].history);

        data.push({ ...stock[0] });
      }

      return data;
    } catch (err) {
      return err;
    }
  },

  getLocationsToDelete: (newLocs, oldLocs) => {
    const idsToDelete = [];

    for (const { id: oldId } of oldLocs) {
      let fount = false;

      for (const { id: newId } of newLocs) {
        if (oldId === newId) {
          fount = true;
          break;
        }
      }

      if (!fount) idsToDelete.push(oldId);
    }

    return idsToDelete;
  },

  getLocationsToInsert: (newLocs, oldLocs) => {
    const locationsToInsert = [];

    for (const newLoc of newLocs) {
      let fount = false;

      for (const { id: oldId } of oldLocs) {
        if (oldId === newLoc.id) {
          fount = true;
          break;
        }
      }

      if (!fount) locationsToInsert.push({ name: newLoc.name, value: newLoc.value });
    }

    return locationsToInsert;
  },

  updateLocations: async ({ id, locations: newLocs }, oldLocs) => {
    try {
      const locationsToDelete = utils.getLocationsToDelete(newLocs, oldLocs);
      const locationsToInsert = utils.getLocationsToInsert(newLocs, oldLocs);

      for (const location of locationsToDelete) {
        const res = await runQuery(queries.stock.deleteLocationRelation(), [location, id]);
        if (res instanceof Error) throw new Error(`updateLocations: ${res}`);
      }

      for (const location of locationsToInsert) {
        const res = await utils.createLocations([location]);
        if (res instanceof Error) throw new Error(`updateLocations ${res}`);
        const relation = await utils.createLocationRelations(res, id);

        if (relation instanceof Error) throw new Error(`updateLocations: ${relation}`);
      }

      return true;
    } catch (err) {
      return err;
    }
  },

  patchItem: async (user, data, history, locations = false) => {
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
        [data.sku, data.quantity, generic.poundsToPennies(data.price), "null", 0, data.id]
      );
      if (update instanceof Error) throw new Error(`patchItem: ${update}`);

      const hist = await utils.createHistory(history);

      if (hist instanceof Error) throw new Error(`patchItem: ${hist}`);

      const locRes = locations && (await utils.updateLocations(data, history.locations));
      if (locRes instanceof Error) throw new Error(`patchItem: ${locRes}`);

      return true;
    } catch (err) {
      return err;
    }
  },
};

module.exports = utils;
