#cls

$UserAlias = $env:USERNAME


write-Host `n '             MCIO-E Tier2 Team
***Script for copy folders***'`n -Foregroundcolor yellow

while(1)
{

# Here we will set the source and remote share location and path
$SourceDir = "E$\SCM\SCM\Logging"  
$RemoteSharePath = "D$\Tier2_Logging_Backup"
#$RemoteSharePath = "\\Co1ebsscmpweb01\d$\Tier2_Logging_Backup"

$AllRemoteSharePathsExist = $True
$global:ServerName


write-Host "Select any one below server:"`n -ForegroundColor Magenta
 
Write-host '1. CO1EBSSCMPWEB01'`n -ForegroundColor DarkYellow
Write-host '2. CO1EBSSCMPWEB02'`n -ForegroundColor DarkYellow
write-host '3. CO1EBSSCMPWEB05'`n -ForegroundColor DarkYellow
write-host '4. CO1EBSSCMPWEB06'`n -ForegroundColor DarkYellow
write-host '5. Exit'`n -ForegroundColor DarkYellow

$Option = read-host "Enter your option"

If($Option -eq 1){$ServerName = 'CO1EBSSCMPWEB01'}
elseif($Option -eq 2){$ServerName = 'CO1EBSSCMPWEB02'}
elseif($Option -eq 3){$ServerName = 'CO1EBSSCMPWEB05'}
elseif($Option -eq 4){$ServerName = 'CO1EBSSCMPWEB06'}
elseif($Option -eq 5){
Write-Host `n "You have successfully exited from the script"  -ForegroundColor Green  
sleep -seconds 5
exit
}
else{
    write-Host "Entered option is wrong.....Going to exit from console in 5 seconds"`n -ForegroundColor red
    sleep -seconds 5 
    Exit
    }


   If (( (Test-Path "\\$ServerName\$RemoteSharePath") -And (Test-Path "\\$ServerName\$SourceDir") ) -eq $false) {
        #Write-Host -ForegroundColor Red "[PreCheck Error] \\$ServerName\$RemoteSharePath does not exist"
         write-host 
       write-host "Please check your path" -ForegroundColor white -BackgroundColor red
       write-host 
        $AllRemoteSharePathsExist = $False 
        
             
    }


If ($AllRemoteSharePathsExist) {
 write-host 
    Write-Host "[$ServerName] Copying $SourceDir to \\$ServerName\$RemoteSharePath " -ForegroundColor black -BackgroundColor green 
  robocopy "\\$ServerName\$SourceDir"  "\\$ServerName\$RemoteSharePath\Logging_bkup$(((get-date).ToLocalTime()).ToString("MMddyyyy"))" /s /J /MT:16 /NFL /NDL /NS /NC /NP /R:1 /W:1 /ETA
     write-host 
    }

   
}#while