// MARK: Target Scope
targetScope = 'subscription'

// MARK: Imports
import { StorageAccount, ContainerRegistry } from 'modules/types.bicep'

// MARK: Parameters
// MARK: General
param location string
param tags object

// MARK: Storage Accounts
param storageAccountResourceGroupName string
param storageAccountTerraform StorageAccount

// MARK: Container Registries
param containerRegistryResourceGroupName string
param containerRegistryMercurius ContainerRegistry

// MARK: Resources
// MARK: Storage Account
// MARK: Storage Account Resource Group
resource rgStorageAccount 'Microsoft.Resources/resourceGroups@2024-11-01' = {
  name: storageAccountResourceGroupName
  location: location
  tags: tags
}

// MARK: Storage Account - Terraform
module stTerraform 'modules/storageAccount.bicep' = {
  scope: rgStorageAccount
  params: {
    storageAccount: storageAccountTerraform
  }
}

// MARK: Container Registries
// MARK: Container Registry Resource Group
resource rgContainerRegistry 'Microsoft.Resources/resourceGroups@2024-11-01' = {
  name: containerRegistryResourceGroupName
  location: location
  tags: tags
}

// MARK: Container Registry - Mercurius
module crMercurius 'modules/containerRegistry.bicep' = {
  scope: rgContainerRegistry
  params: {
    containerRegistry: containerRegistryMercurius
  }
}
