#!/bin/sh

# Exit immediately if a command exits with a non-zero status
set -e

# Install dependencies
echo "Installing dependencies..."
npm install

# Fix vulnerabilities
echo "Fixing vulnerabilities..."
npm audit fix --force

# Compile contracts
echo "Compiling contracts..."
truffle compile

# Run tests
echo "Running tests..."
truffle test

# Deploy the project
echo "Deploying the project..."
truffle migrate --network amoy

echo "Setup and deployment completed successfully."