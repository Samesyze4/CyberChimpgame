require('dotenv-safe').config();
const HDWalletProvider = require('@truffle/hdwallet-provider');

module.exports = {
  networks: {
    amoy: {
      provider: () => new HDWalletProvider(process.env.PRIVATE_KEY, process.env.AMOY_URL),
      network_id: '*', // Match any network id
    },
  },
  compilers: {
    solc: {
      version: "0.8.19", // Specify the Solidity compiler version
    },
  },
};