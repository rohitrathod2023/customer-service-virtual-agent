targetScope = 'resourceGroup'

@description('Storage account name')
param storageAccountName string

resource st 'Microsoft.Storage/storageAccounts@2022-09-01' = {
  name: storageAccountName
  location: resourceGroup().location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
}


@description('App Service Plan name')
param appServicePlanName string = 'asp-csvc-dev-sea-001'

@description('Web App name')
param webAppName string = 'api-csvc-dev-sea-001'

resource asp 'Microsoft.Web/serverfarms@2022-09-01' = {
  name: appServicePlanName
  location: resourceGroup().location
  kind: 'linux'  // This is important
  properties: {
    reserved: true  // This must be true for Linux
  }
  sku: {
    name: 'B1'  // or your preferred SKU
    tier: 'Basic'
  }
}

resource webapp 'Microsoft.Web/sites@2022-09-01' = {
  name: webAppName
  location: resourceGroup().location
  properties: {
    serverFarmId: asp.id
    siteConfig: {
      
    }
  }
}