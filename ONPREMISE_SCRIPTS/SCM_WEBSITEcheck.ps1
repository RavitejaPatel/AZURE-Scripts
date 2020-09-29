cls

 

$UserAlias = Read-Host "Enter your Alias(V-ID)"

 

while(1)
{
write-Host '*****Script for generating the Website Availability Status Report*****'`n -Foregroundcolor Magenta

 


write-Host "Select any one below server:"`n -ForegroundColor Magenta
 
Write-host "1. CO1EBSSCMPWEB01"`n -ForegroundColor DarkYellow
Write-host "2. CO1EBSSCMPWEB02"`n -ForegroundColor DarkYellow
write-host "3. CO1EBSSCMPWEB05"`n -ForegroundColor DarkYellow
write-host "4. CO1EBSSCMPWEB06"`n -ForegroundColor DarkYellow
write-host "5. gfsscmint"`n -ForegroundColor DarkYellow
write-host "6. Exit"`n -ForegroundColor DarkYellow
 
$Option = read-host "Enter your option"`n

 

If($Option -eq 1){$ServerName = 'CO1EBSSCMPWEB01'}
elseif($Option -eq 2){$ServerName = 'CO1EBSSCMPWEB02'}
elseif($Option -eq 3){$ServerName = 'CO1EBSSCMPWEB05'}
elseif($Option -eq 4){$ServerName = 'CO1EBSSCMPWEB06'}
elseif($Option -eq 5){$ServerName = 'gfsscmint'}
elseif($Option -eq 6){
Write-Host "You have successfully exited from the script" -ForegroundColor Green
Exit
}
else{
    write-Host "Entered option is wrong"`n -ForegroundColor red
    Exit
    }

 

$URLList = @(("https://$ServerName"+":8092/SCMAXPortalService"),
            "https://$ServerName.corp.microsoft.com:8192/",
            "https://$ServerName.corp.microsoft.com:8192/AssetLifeCycleService?wsdl",
             "https://$ServerName.corp.microsoft.com:8192/TransferService?wsdl",
             "https://$ServerName.corp.microsoft.com:8192/NonconfService?wsdl",
             "https://$ServerName.corp.microsoft.com:8192/WarrantyService?wsdl",
             "https://$ServerName.corp.microsoft.com:8092/AxAssetLifeCycleService",
             "https://$ServerName.corp.microsoft.com:8192/PortalService?wsdl",
             "https://$ServerName/#/Home",
             "https://$ServerName/Services/ScmAsset.svc/",
             ("https://$ServerName"+":8092/SCMAXPortalService"),
             "https://$ServerName/healthbeat")
         
$Result = @()

 

  Foreach($Uri in $URLList) 
 {
  $time = try{
  $request = $null
   ## Request the URI and measure how long the response took.
  $result1 = Measure-Command { $request = Invoke-WebRequest -Uri $uri -UseDefaultCredentials }
  $result1.Totalseconds

 

  } 
  catch
  {
   <# If the request generated an exception (i.e.: 500 server
   error or 404 not found), we can pull the status code from the
   Exception.Response property #>
   $request = $_.Exception.Response
   $time = -1
  }  
  $result += [PSCustomObject] @{
  Time = Get-Date;
  Uri = $uri;
  StatusCode = [int] $request.StatusCode;
  StatusDescription = $request.StatusDescription;
  ResponseLength = $request.RawContentLength;
  TimeTaken =  $time;
  }

 

}https://CO1EBSSCMPWEB05/Services/ScmAsset.svc/
    #Prepare email body in HTML format
if($result -ne $null)
{
    $Outputreport = "<HTML><TITLE> Website Availability Status </TITLE><BODY background-color:peachpuff><font color =""#99000"" face=""Microsoft Taile""><H2> SCM URL Health status for $ServerName </H2></font><Table border=1 cellpadding=0 cellspacing=0><TR bgcolor=gray align=center><TD><B>URL</B></TD><TD><B>StatusCode</B></TD><TD><B>StatusDescription</B></TD><TD><B>ResponseLength</B></TD><TD><B>TimeTaken(in sec)</B></TD</TR>"
    Foreach($Entry in $Result)
    {
        if($Entry.StatusCode -ne "200")
        {
            $Outputreport += "<TR bgcolor=red>"
        }
        else
        {
            $Outputreport += "<TR bgcolor=green>"
        }
        $Outputreport += "<TD>$($Entry.uri)</TD><TD align=center>$($Entry.StatusCode)</TD><TD align=center>$($Entry.StatusDescription)</TD><TD align=center>$($Entry.ResponseLength)</TD><TD align=center>$($Entry.timetaken)</TD></TR>"
    }
    $Outputreport += "</Table></BODY></HTML>"
}

 

Write-Host "Output html file is saved on your desktop" -ForegroundColor Green

 

$Outputreport | out-file C:\Users\$UserAlias\Desktop\SCMWebsiteHealthStatusReport.htm
Invoke-Expression C:\Users\$UserAlias\Desktop\SCMWebsiteHealthStatusReport.htm
}