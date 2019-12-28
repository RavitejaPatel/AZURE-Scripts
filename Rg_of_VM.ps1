cls
$resourceArray = @()

#$Global:count
$count=0;

$resourceArray=Get-AzResource

$VMresourceGroups=@()


foreach($rgname in $resourceArray)
{
if($rgname.ResourceType -eq "Microsoft.Compute/virtualMachines")
{
$count+=1;
$VMresourceGroups+=$rgname.ResourceGroupName
write-host "no of resource groups contains VM'S are:"$count -ForegroundColor Green

}#if
}#for

Write-host "------------------------------------------------------------" -ForegroundColor DarkGray

foreach($vmrg in $VMresourceGroups)
{
Write-Host "Virtual Machines are present under resource groups" -BackgroundColor Cyan $vmrg -ForegroundColor DarkMagenta

}


