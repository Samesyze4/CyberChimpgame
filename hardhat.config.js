require("dotenv-safe").config(); // Use require for dotenv-safe

module.exports = {
  solidity: "0.8.19",
  networks: {
    amoy: {
      url: process.env.AMOY_URL, // Use the URL from the .env file
      accounts: [process.env.PRIVATE_KEY], // Use the private key from the .env file
    },
  },
};
