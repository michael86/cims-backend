const utils = {
  poundsToPennies: (amount) => Math.floor(parseFloat(amount) * 100),

  penniesToPounds: (amount) => Math.floor(parseFloat(amount) / 100),

  convertDateToUnix: (date) => Math.floor(new Date(date).getTime() / 1000),

  convertUnixToLocale: (date) => new Date(date * 1000).toLocaleDateString(),
};

module.exports = utils;
