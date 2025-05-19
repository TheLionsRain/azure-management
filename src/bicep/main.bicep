// MARK: Target Scope
targetScope = 'subscription'

// MARK: Imports
import { StorageAccount } from 'modules/types.bicep'

// MARK: Parameters
// MARK: General
param location string
param tags object

// MARK: Storage Accounts
param storageAccountResourceGroupName string
param storageAccountTerraform StorageAccount

// MARK: Resources
// MARK: Storage Account
// MARK: Storage Account Resource Group
resource rgStorageAccount 'Microsoft.Resources/resourceGroups@2024-11-01' = {
  name: storageAccountResourceGroupName
  location: location
  tags: tags
}

// MARK: Storage Account - Terraform
module saTerraform 'modules/storageAccount.bicep' = {
  scope: rgStorageAccount
  params: {
    storageAccount: storageAccountTerraform
  }
}
