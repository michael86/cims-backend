const utils = {
  poundsToPennies: (amount) => Math.floor(parseFloat(amount) * 100),

  penniesToPounds: (amount) => Math.floor(parseFloat(amount) / 100),
};

module.exports = utils;
