$storageAccountName="mystuffdisks" 
$resourceGroup="mystuff"

# retrieve the first storage account key and display it 
$storageAccountKey = (Get-AzStorageAccountKey -ResourceGroupName $resourceGroup -Name $storageAccountName).Value[0]

Write-Host "storage account key 1 = " $storageAccountKey


$storageAccountKey = (Get-AzStorageAccountKey -ResourceGroupName $resourceGroup -Name $storageAccountName).Value[1]

Write-Host "storage account key 2 = " $storageAccountKey

# re-generate the key1
New-AzStorageAccountKey -ResourceGroupName $resourceGroup -Name $storageAccountName -KeyName key1

# retrieve it again and display key1 it 
$storageAccountKey = (Get-AzStorageAccountKey -ResourceGroupName $resourceGroup -Name $storageAccountName).Value[0] 
Write-Host "storage account key 1 = " $storageAccountKey

# re-generate the key2
New-AzStorageAccountKey -ResourceGroupName $resourceGroup -Name $storageAccountName -KeyName key2

# retrieve it again and display key2 it 
$storageAccountKey = (Get-AzStorageAccountKey -ResourceGroupName $resourceGroup -Name $storageAccountName).Value[1] 
Write-Host "storage account key 2 = " $storageAccountKey



