$RgName = "RESOURCEGROUPNAME"
$Location = "LOCATION" 
#SAVE YOUR PASSWORD IN SOME TEXT FILE AND PROVIDE PATH BELOW
$pass=Get-Content -Path "PATH OF FILE WHERE YOU SAVED YOUR PASSWORD"
$vmnames=@()
$vmnames=(get-azvm -ResourceGroupName $RgName).Name 

#USERNAME , PASSWORD


foreach($VmName in $vmnames )
{

$User = $VmName
$PWord = ConvertTo-SecureString -String $pass -AsPlainText -Force
$Credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $User, $PWord

Set-AzVMAccessExtension -ResourceGroupName $RgName -Location $Location -VMName $VmName -Credential $Credential -TypeHandlerVersion "2.0" -Name VMAccessAgent
Restart-AzVM -ResourceGroupName $RgName -Name $VmName

}


#Get-AzVMAccessExtension -ResourceGroupName $RgName -VMName -Name $extensionname