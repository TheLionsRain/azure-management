// MARK: Target Scope
targetScope = 'resourceGroup'

// MARK: Imports
import { StorageAccount } from 'types.bicep'

// MARK: Parameters
param storageAccount StorageAccount

// MARK: Resources
// MARK: Storage Account
resource sa 'Microsoft.Storage/storageAccounts@2024-01-01' = {
  name: storageAccount.name
  location: storageAccount.location
  sku: {
    name: storageAccount.sku.name
  }
  kind: storageAccount.kind
}

// MARK: Blob Service
resource saBlobService 'Microsoft.Storage/storageAccounts/blobServices@2024-01-01' = {
  parent: sa
  name: 'default'
}

// MARK: Containers
resource saContainers 'Microsoft.Storage/storageAccounts/blobServices/containers@2024-01-01' = [
  for container in storageAccount.containers: {
    parent: saBlobService
    name: container.name
  }
]

// MARK: Outputs
output id string = sa.id
output name string = sa.name
output location string = sa.location
