const fs = require('fs');
const { execSync } = require('child_process');

// Function to check if a module is installed
function ensureDependency(moduleName) {
  try {
    require.resolve(moduleName);
  } catch (e) {
    console.log(`⚠️  ${moduleName} not found. Installing...`);
    execSync(`npm install ${moduleName}`, { stdio: 'inherit' });
  }
}

// Ensure required dependencies are installed
ensureDependency('dotenv-safe');
ensureDependency('@truffle/hdwallet-provider');

// Load environment variables
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
