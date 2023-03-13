module.exports.genToken = (count = 50, includeSpecial=true) => {
  let letters =
    `abcdefghijklmnopqrstuvwxyzABCDEFGHIHJKLMNOPQRSTUVWXYZ1234567890${includeSpecial && '!"£$%^&*()_+-'}`;

   
  let token = "";
  for (let i = 0; i <= count; i++) {
    token += letters.charAt(Math.floor(Math.random() * letters.length));
  }

  return (token += Date.now());
};
