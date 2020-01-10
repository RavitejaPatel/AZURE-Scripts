$number_of_days_threshold = 5
$current_date = get-date
$date_before_blobs_to_be_deleted = $current_date.AddDays(-$number_of_days_threshold)
$Global:count
$count=0
# Number of blobs deleted
$blob_count_deleted = 0

# Storage account details
$storage_account_name = "StorageACC" 
$storage_account_key = "Access key"
$container = "CONTAINER NAME"
$rgname="RG NAME"

## Creating Storage context for Source, destination and log storage accounts
$context = New-AzStorageContext -StorageAccountName $storage_account_name -StorageAccountKey $storage_account_key
$blob_list = Get-AzStorageBlob -Context $context -Container $container


## Iterate through each blob
foreach($blob_iterator in $blob_list){

 write-host "hi" -ForegroundColor green
#$count=$count+1

    $blob_date = [datetime]$blob_iterator.LastModified.UtcDateTime
    
    # Check if the blob's last modified date is less than the threshold date for deletion
    if($blob_date -le $date_before_blobs_to_be_deleted) {

   

     if(  ((Get-AzStorageAccount -name $storage_account_name -ResourceGroupName $rgname | Get-AzStorageBlob -name $container).ICloudBlob).Properties.LeaseStatus -eq "locked" )
    {
  

(Get-AzStorageAccount -name $storage_account_name -ResourceGroupName $rgname | Get-AzStorageBlob -name $container).ICloudBlob.BreakLease()

   
   }
#inner if  
  }



    }

     