module.exports.getLocationsToDelete = (newLocs, oldLocs) => {
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
};

module.exports.getLocationsToInsert = (newLocs, oldLocs) => {
  const locationsToInsert = [];

  for (const newLoc of newLocs) {
    let fount = false;

    for (const { id: oldId } of oldLocs) {
      if (oldId === newLoc.id) {
        fount = true;
        break;
      }
    }

    if (!fount)
      locationsToInsert.push({ name: newLoc.name, value: newLoc.value });
  }

  return locationsToInsert;
};
