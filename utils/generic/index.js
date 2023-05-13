const utils = {
  poundsToPennies: (amount) => Number(Math.floor(parseFloat(amount) * 100).toFixed(2)),

  penniesToPounds: (amount) => Number(parseFloat(amount / 100).toFixed(2)),

  convertDateToUnix: (date) => Math.floor(new Date(date).getTime() / 1000),

  convertUnixToLocale: (date) => new Date(date * 1000).toLocaleDateString(),
};

module.exports = utils;
