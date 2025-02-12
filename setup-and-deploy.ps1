# Ensure the correct Node.js version is used
Write-Host "Checking Node.js version..."
$nodeVersion = node -v
if ($nodeVersion -lt "v14.0.0") {
    Write-Host "Node.js version 14 or higher is required. Please update Node.js."
    exit 1
}

# Install dependencies
Write-Host "Installing dependencies..."
npm install

# Fix vulnerabilities
Write-Host "Fixing vulnerabilities..."
npm audit fix --force

# Run tests
Write-Host "Running tests..."
npx hardhat test

# Deploy the project
Write-Host "Deploying the project..."
npx hardhat run scripts/deploy.js --network amoy

Write-Host "Setup and deployment completed successfully."