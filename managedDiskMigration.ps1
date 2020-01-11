#Source storage account
$rgName ="RG_NAME"
$location ="RG_LOCATION"
$storageAccountName ="STORAGE_ACC_NAME"
$diskName ="DISK_NAME"

#Target storage account
$destrgName ="DESTINATION RG NAME"
$destlocation ="RG LOCATION"
$deststorageAccountName ="STORAGE ACC NAME"
$destdiskName ="SELECT DEST DISK NAME YOU WANT TO SAVE DISK AS"
 
#Assign access to the source disk
$sas =Grant-AzDiskAccess -ResourceGroupName $rgName -DiskName $diskName -DurationInSecond 3600 -Access Read

$saKey =Get-AzStorageAccountKey -ResourceGroupName $destrgName -Name $deststorageAccountName
$storageContext =New-AzStorageContext –StorageAccountName $deststorageAccountName -StorageAccountKey $saKey[0].Value
New-AzStorageContainer -Context $storageContext -Name "CONTAINER NAME"

Start-AzStorageBlobCopy -AbsoluteUri $sas.AccessSAS -DestContainer "CONTAINER NAME" -DestContext $storageContext -DestBlob $destdiskName

Get-AzStorageBlobCopyState -Context $storageContext -Blob $destdiskName -Container "CONTAINER NAME"
