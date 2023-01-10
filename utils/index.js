module.exports.genToken = (count = 50) => {
  const letters =
    'abcdefghijklmnopqrstuvwxyzABCDEFGHIHJKLMNOPQRSTUVWXYZ!"£$%^&*()_+1234567890-';

  let token = "";
  for (let i = 0; i <= count; i++) {
    token += letters.charAt(Math.floor(Math.random() * letters.length));
  }

  return (token += Date.now());
};
