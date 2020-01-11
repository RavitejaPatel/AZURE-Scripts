<#

This script will gathers all resources group list from our azure portal and sends count of Resource groups to our mail id
This script do api calls to gmail,to make this script run you should enable "access to less secure app follow this link"https://myaccount.google.com/lesssecureapps" 
#>




#$param =
cls
#{
#Get-AzResourceGroup
#}

#$param.resourcegroupname

 
 $Body =''  

$RGcontent = @(
Get-AzResourceGroup
)

$RSGroups = @(
$RGcontent.resourcegroupname
)

$count=1;

$global:vmCollection


foreach($rg in $RSGroups)
{
write-host $rg
$var=$count++
}
write-host "no of RESOURCE-GROUP NAMES---------+$var"
  
$Body = $Body + " <br > no of RESOURCE-GROUP NAMES : $var </br>  " 

write-host "pushing to mail"

$SMTPServer = "smtp.gmail.com"
$SMTPPort = "25"
$SMTPPort = "587"
$Username = "raviteja.idams134@gmail.com"
$Password = Read-Host 'What is your password?' -AsSecureString

$to = "ravitejapatel567@gmail.com"
#$cc = "user2@domain.com"
$subject = "resource info"
#$body = "check it out"
#$attachment = "C:\test.txt"

$message = New-Object System.Net.Mail.MailMessage
$message.subject = $subject
$message.body = $body
$message.to.add($to)
#$message.cc.add($cc)
$message.from = $username
#$message.attachments.add($attachment)

$smtp = New-Object System.Net.Mail.SmtpClient($SMTPServer, $SMTPPort);
$smtp.EnableSSL = $true
$smtp.Credentials = New-Object System.Net.NetworkCredential($Username, $Password);
$smtp.send($message)
write-host "Mail Sent"