Function set-blobarchive
{
[CmdletBinding()]

Param
    (
         [Parameter(Mandatory=$true, Position=0)]
         [string] $StgAcc,
         [Parameter(Mandatory=$true, Position=1)]
          [string]$StgKey,
         [Parameter(Mandatory=$true, Position=2)]
         [string] $container_name,
         [Parameter(Mandatory=$true, Position=3)]
         [string] $prefix
         
    )



PROCESS
{



$ctx = New-AzStorageContext -StorageAccountName $StgAcc -StorageAccountKey $StgKey


#Get all the blobs in container
$blobs = Get-AzStorageBlob -Container $container_name -Context $ctx -Prefix $prefix

$totalblob=@($blobs)

ForEach ($tb in $totalblob) {

 $tb.icloudblob.setstandardblobtier("Archive")

 }

} #PROCESS


} #Function


