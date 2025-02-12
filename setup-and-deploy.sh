#!/bin/sh

# Install dependencies
echo "Installing dependencies..."
npm install

# Fix vulnerabilities
echo "Fixing vulnerabilities..."
npm audit fix --force

# Run tests
echo "Running tests..."
npx hardhat test

# Deploy the project
echo "Deploying the project..."
npx hardhat run scripts/deploy.js --network amoy

echo "Setup and deployment completed successfully."