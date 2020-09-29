#Login-AzureRmAccount

#Source Subscription



#Select-AzureRmSubscription -SubscriptionId '2e7ebdbb-0faf-44f8-8858-ba8a2277f3c3’
#casevnetblob

$sas = Grant-AzDiskAccess -ResourceGroupName "CASE_RG" -DiskName "casesnapTOdisk" -DurationInSecond 3600 -Access Read 


$destContext = New-AzStorageContext –StorageAccountName "casevnetstrgacc2" -StorageAccountKey "w5fUTAVfIGhslEt8AV3A85/9T8ODFfHERDqZIpGBUU/MlZK34cN2bF63B1OS2z8icvMS6twhGm5s6+Yxyc7DXg=="

$blobcopy=Start-AzStorageBlobCopy -AbsoluteUri $sas.AccessSAS -DestContainer "casevnetcontainer2" -DestContext $destContext -DestBlob "vm1disk.vhd"



while(($blobCopy | Get-AzStorageBlobCopyState).Status -eq "Pending")

{

    Start-Sleep -s 30

    $blobCopy | Get-AzStorageBlobCopyState

} 

 