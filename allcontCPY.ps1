

$SourceStorageAccountName = "testdisks587"


$SourceStorageKey = Get-AzStorageAccountKey -StorageAccountName $SourceStorageAccountName -ResourceGroupName test
$StorageContext = New-AzStorageContext -StorageAccountName $SourceStorageAccountName -StorageAccountKey $SourceStorageKey.GetValue(0).value


 $containers=(Get-AzStorageContainer -Context $storagecontext).name

 foreach($container in $containers)
 {
  "Transfer container " + $container

   $cmd =  /Source:" + $c.CloudBlobContainer.Uri.AbsoluteUri + " /Dest: +"youfile path"

   azcopy copy "C:\Users\RavitejaPatelPoosala\Downloads\ApplicationFormDraftPrintForAll.pdf" "$container.



 }

 https://testdisks587.blob.core.windows.net/testdj
 https://testdisks587.blob.core.windows.net/?sv=2018-03-28&ss=bfqt&srt=sco&sp=rwdlacup&se=2019-10-13T14:59:12Z&st=2019-10-13T06:59:12Z&spr=https&sig=6yq5500vpldUg4FKGgDqwlTuzP9DBd04qqAMjS5ArxY%3D





