#Source storage account
$rgName ="ARM_TEMP"
$location ="East Asia"
$storageAccountName ="armtempdiag"
$diskName ="ubuntu1_OsDisk_1_977ed3cb577241ef9fb8fbef0c64978a"

#Target storage account
$destrgName ="roger01"
$destlocation ="West Europe"
$deststorageAccountName ="roger109teja"
$destdiskName ="destrogerdisk"
 
#Assign access to the source disk
$sas =Grant-AzDiskAccess -ResourceGroupName $rgName -DiskName $diskName -DurationInSecond 3600 -Access Read

$saKey =Get-AzStorageAccountKey -ResourceGroupName $destrgName -Name $deststorageAccountName
$storageContext =New-AzStorageContext –StorageAccountName $deststorageAccountName -StorageAccountKey $saKey[0].Value
New-AzStorageContainer -Context $storageContext -Name vhds10261

Start-AzStorageBlobCopy -AbsoluteUri $sas.AccessSAS -DestContainer vhds10261 -DestContext $storageContext -DestBlob $destdiskName

Get-AzStorageBlobCopyState -Context $storageContext -Blob $destdiskName -Container vhds10261