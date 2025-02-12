# Install dependencies
Write-Host "Installing dependencies..."
npm install

# Fix vulnerabilities
Write-Host "Fixing vulnerabilities..."
npm audit fix

# Run tests
Write-Host "Running tests..."
npm test

# Deploy the project
Write-Host "Deploying the project..."
npm run deploy

Write-Host "Setup and deployment completed successfully."