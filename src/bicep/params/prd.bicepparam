// MARK: Usings
using '../main.bicep'

// MARK: Variables
var locationShortName = 'ne'

// MARK: Resource Naming
// MARK: Storage Accounts
var storageResourceGroupName = 'rg-management-storage-${locationShortName}'
var storageAccountTerraformName = 'stterraformmgmttcrk${locationShortName}'

// MARK: General
param location = 'northeurope'
param tags = {
  Owner: 'Michiel Van Herreweghe'
  CreatedWith: 'Bicep'
  Purpose: 'Management'
}

// MARK: Storage Accounts
param storageAccountResourceGroupName = storageResourceGroupName
param storageAccountTerraform = {
  name: storageAccountTerraformName
  location: location
  sku: {
    name: 'Standard_ZRS'
  }
  kind: 'StorageV2'
  tags: tags
  containers: [
    {
      name: 'c-tfstate-homelab-helheim'
    }
  ]
  roleAssignments: [
    {
      principalId: 'a176ebb0-c01d-473a-8205-2370942a9e9e' // sp-gh-homelab
      principalType: 'ServicePrincipal'
      roleDefinitionId: 'ba92f5b4-2d11-453d-a403-e96b0029c9fe' // Storage Blob Data Contributor
    }
  ]
}


// MARK: Container Registries
param containerRegistryResourceGroupName = 'rg-management-registries-${locationShortName}'
param containerRegistryMercurius = {
  name: 'mercuriusaalst'
  location: location
  sku: {
    name: 'Standard'
  }
  properties: {
    anonymousPullEnabled: true
  }
  tags: tags
  roleAssignments: [
    {
      principalId: '133659da-2987-49ac-adfb-305b934b45d6' // sp-gh-mercurius-aalst-back-end
      principalType: 'ServicePrincipal'
      roleDefinitionId: 'b24988ac-6180-42a0-ab88-20f7382dd24c' // Contributor
    }
  ]
}
