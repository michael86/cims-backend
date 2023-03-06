module.exports.genToken = (count = 50, includeSpecial = true) => {
  let letters = `abcdefghijklmnopqrstuvwxyzABCDEFGHIHJKLMNOPQRSTUVWXYZ1234567890${
    includeSpecial && '!"£$%^&*()_+-'
  }`;

  let token = "";
  for (let i = 0; i <= count; i++) {
    token += letters.charAt(Math.floor(Math.random() * letters.length));
  }

  return (token += Date.now());
};

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
