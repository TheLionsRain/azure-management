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

// MARK: Role Assignments
resource roleAssignments 'Microsoft.Authorization/roleAssignments@2022-04-01' = [
  for roleAssignment in storageAccount.roleAssignments: {
    scope: sa
    name: guid(roleAssignment.roleDefinitionId, roleAssignment.principalId, sa.name)
    properties: {
      principalId: roleAssignment.principalId
      principalType: roleAssignment.principalType
      roleDefinitionId: subscriptionResourceId('Microsoft.Authorization/roleDefinitions', roleAssignment.roleDefinitionId)
    }
  }
]

// MARK: Outputs
output id string = sa.id
output name string = sa.name
output location string = sa.location
