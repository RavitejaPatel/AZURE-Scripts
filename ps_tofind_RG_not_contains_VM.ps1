
cls
$resourceArray = @()

#$Global:count
$count=0;

$resourceArray=Get-AzResource

$VMresourceGroups=@()
$ALLresourceGroups=@()
$ALLresourceGroupsUnique=@()



foreach($rname in $resourceArray)
{

    if($rname | Where-Object {$_.ResourceId -like "*virtualmachines*"})
     {

      $VMresourceGroups+=$rname.ResourceGroupName
      $count+=1;

       write-host "resource groups contains vm's are : "$VMresourceGroups "----" $count

       }


}#for


foreach($rname in $resourceArray)
{

      $ALLresourceGroups+=$rname.ResourceGroupName 
        

}#for
$ALLresourceGroupsUnique = $ALLresourceGroups | Select -Uniq




foreach($vmrg in $VMresourceGroups)
{

      write-host
      Write-Host "Virtual Machines are present under resource groups" -BackgroundColor Cyan $vmrg -ForegroundColor DarkMagenta

}#for



        Write-host "------------------------------------------------------------" -ForegroundColor DarkGray



#$res = @()
#$res = Compare-Object -ReferenceObject ($resourceArray) -DifferenceObject ($VMresourceGroups) -PassThru




$VMresourceGroups | Where-Object { $ALLresourceGroupsUnique -notcontains $_ }

$final=$ALLresourceGroupsUnique | where {$VMresourceGroups -notcontains $_}


foreach($eachfinal in $final)
{
write-host  "Virtual Machines are NOT present under resource groups" -BackgroundColor yellow $eachfinal

}


