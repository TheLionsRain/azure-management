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

// MARK: Storage Account - Terraform
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
}
