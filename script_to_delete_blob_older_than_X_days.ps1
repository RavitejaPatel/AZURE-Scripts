﻿

## Declaring the variables
$number_of_days_threshold = 0.5
$current_date = get-date
$date_before_blobs_to_be_deleted = $current_date.AddDays(-$number_of_days_threshold)

# Number of blobs deleted
$blob_count_deleted = 0

# Storage account details
$storage_account_name = "testdisks587" 
$storage_account_key = "kMR6qJ3CFeIGsF6Hh3dxCCzTJh+iZ52xj51YhT9xX2DdJYdhlTZ7N4q9ph+XqxgzwQYzhpaUVzmrQk4KAdIEag=="
$container = "vhds"

## Creating Storage context for Source, destination and log storage accounts
$context = New-AzStorageContext -StorageAccountName $storage_account_name -StorageAccountKey $storage_account_key
$blob_list = Get-AzStorageBlob -Context $context -Container $container

## Creating log file
$log_file = "log-"+(get-date).ToString().Replace('/','-').Replace(' ','-').Replace(':','-') + ".txt"
$local_log_file_path = $env:temp + "\" + "log-"+(get-date).ToString().Replace('/','-').Replace(' ','-').Replace(':','-') + ".txt"

write-host "Log file saved as: " $local_log_file_path -ForegroundColor Green

## Iterate through each blob
foreach($blob_iterator in $blob_list){

    $blob_date = [datetime]$blob_iterator.LastModified.UtcDateTime
    
    # Check if the blob's last modified date is less than the threshold date for deletion
    if($blob_date -le $date_before_blobs_to_be_deleted) {

        Write-Output "-----------------------------------" | Out-File $local_log_file_path -Append
        write-output "Purging blob from Storage: " $blob_iterator.name | Out-File $local_log_file_path -Append
        write-output " " | Out-File $local_log_file_path -Append
        write-output "Last Modified Date of the Blob: " $blob_date | Out-File $local_log_file_path -Append
        Write-Output "-----------------------------------" | Out-File $local_log_file_path -Append

        # Cmdle to delete the blob
        Remove-AzStorageBlob -Container $container -Blob $blob_iterator.Name -Context $context

        $blob_count_deleted += 1
    }

}

write-output "Blobs deleted: " $blob_count_deleted | Out-File $local_log_file_path -Append