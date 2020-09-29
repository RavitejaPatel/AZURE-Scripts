#script to change access tiers of selected blobs
$StgAcc = "sTRGaCCnAME"
$StgKey = "Accesskey"
$Container = CONTANER NAME
$ctx = New-AzStorageContext -StorageAccountName $StgAcc -StorageAccountKey $StgKey


#Get all the blobsobjects in container
$blobs = Get-AzStorageBlob -Container $Container -Context $ctx
$totalblob=@($blobs)

#assign blob names with extensions in array2
$array2 = @('Microsoft.Azure.PowerShell.Clients.Storage.Management.dll','numdest.txt','Microsoft.Win32.Registry.dll','Microsoft.Azure.PowerShell.Strategies.dll','raviteja.docx')
$final=@()
$names=@()

ForEach ($tb in $totalblob)
   {

      $blobname=($tb.name).split("/")
      $index=$blobname.count - 1 
      $names=$names+$blobname.getvalue($index) 


    ForEach ($a2 in $array2) 
        {

  
          if (($names -eq $a2) -and ($tb.name -like "*$a2") ) 
           {
            
              write-host -----------------------------$a2---------------------------
              $final=$final+$tb
            }


          }#innerfor
      }#outerfor

      

  Write-Warning "are you ready to change the access tiers of ABOVE blobs??" -WarningAction Inquire


          foreach($each in $final)
          {
              $each.icloudblob.setstandardblobtier("cool") 

          }
