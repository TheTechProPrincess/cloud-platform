// Deploys a reusable environment: resource group-level resources
// Parameters allow this same file to deploy sandbox, dev, or prod
param environmentName string = 'sandbox'
param location string = resourceGroup().location

resource storageAccount 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: 'cloudplat${environmentName}storage'
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
}

resource appServicePlan 'Microsoft.Web/serverfarms@2023-01-01' = {
  name: 'cloudplat-${environmentName}-plan'
  location: location
  sku: {
    name: 'F1'
    tier: 'Free'
  }
}

resource webApp 'Microsoft.Web/sites@2023-01-01' = {
  name: 'cloudplat-${environmentName}-app'
  location: location
  properties: {
    serverFarmId: appServicePlan.id
  }
}
