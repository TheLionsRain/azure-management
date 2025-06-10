// MARK: Target Scope
targetScope = 'resourceGroup'

// MARK: Imports
import { ContainerRegistry } from 'types.bicep'

// MARK: Parameters
param containerRegistry ContainerRegistry

// MARK: Resources
resource cr 'Microsoft.ContainerRegistry/registries@2025-04-01' = {
  name: containerRegistry.name
  location: containerRegistry.location
  sku: {
    name: containerRegistry.sku.name
  }
  tags: containerRegistry.tags
}

// MARK: Role Assignments
resource roleAssignments 'Microsoft.Authorization/roleAssignments@2022-04-01' = [
  for roleAssignment in containerRegistry.roleAssignments: {
    scope: cr
    name: guid(roleAssignment.roleDefinitionId, roleAssignment.principalId, cr.name)
    properties: {
      principalId: roleAssignment.principalId
      principalType: roleAssignment.principalType
      roleDefinitionId: subscriptionResourceId('Microsoft.Authorization/roleDefinitions', roleAssignment.roleDefinitionId)
    }
  }
]


// MARK: Outputs
output id string = cr.id
output name string = cr.name
output location string = cr.location
