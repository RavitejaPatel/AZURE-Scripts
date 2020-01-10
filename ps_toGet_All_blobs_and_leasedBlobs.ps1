$number_of_days_threshold = 5
$current_date = get-date
$date_before_blobs_to_be_deleted = $current_date.AddDays(-$number_of_days_threshold)
$Global:count
$count=0
# Number of blobs deleted
$blob_count_deleted = 0

# Storage account details
$storage_account_name = "azurebcdrdisks" 
$storage_account_key = "fC3JZ6e9yuF8LXi0xJ7wfpIrod2ljfkgNMJYsnBkFYLOR9K5qOZePd97n67rlsy3vbpuqAO93+EGuicEnv7UmA=="
$container = "vhds"
$rgname="Azure_BCDR"

## Creating Storage context for Source, destination and log storage accounts
$context = New-AzStorageContext -StorageAccountName $storage_account_name -StorageAccountKey $storage_account_key
$blob_list = Get-AzStorageBlob -Context $context -Container $container



write-host "---------------------------------------------------" -BackgroundColor DarkGray CHECK THE OUTPUT "----------------------------------------------------------" 

Write-Host "List of all blobs which are available and leased are :"

## Iterate through each blob
foreach($blob_iterator in $blob_list){

$count=$count+1

Write-Host  $count"."($blob_iterator).Name -ForegroundColor Magenta

write-host "----------------------------------" 
Write-Host 
 


    $blob_date = [datetime]$blob_iterator.LastModified.UtcDateTime
    
    # Check if the blob's last modified date is less than the threshold date for deletion
    if($blob_date -le $date_before_blobs_to_be_deleted) {

   

     if(  ((Get-AzStorageAccount -name $storage_account_name -ResourceGroupName $rgname | Get-AzStorageBlob -name $container).ICloudBlob).Properties.LeaseStatus -eq "locked" )
    {

    Write-host "your blob lists which are in leased state are:" -BackgroundColor Cyan

   Write-Host ($blob_iterator).Name  | Out-File C:\Users\m1040509\Pictures\Screenshots\myblobs.txt

   
   }
#inner if


  
  }



    }

      