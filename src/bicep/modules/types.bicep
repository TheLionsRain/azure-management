// MARK: Storage Account
@export()
type StorageAccount = {
  name: string
  location: string
  sku: {
    name: ('PremiumV2_LRS' | 'PremiumV2_ZRS' | 'Premium_LRS' | 'Premium_ZRS' | 'StandardV2_GRS' | 'StandardV2_GZRS' | 'StandardV2_LRS' | 'StandardV2_ZRS' | 'Standard_GRS' | 'Standard_GZRS' | 'Standard_LRS' | 'Standard_RAGRS' | 'Standard_RAGZRS' | 'Standard_ZRS')
  }
  kind: ('StorageV2' | 'BlobStorage' | 'BlockBlobStorage' | 'FileStorage')
  tags: object
  containers: StorageAccountContainer[]
}

type StorageAccountContainer = {
  name: string
}
