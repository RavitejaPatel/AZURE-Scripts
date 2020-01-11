$Body =''  
$ResourceGroupColl = Get-AzResourceGroup  
foreach($ResourceGroup in $ResourceGroupColl)  
{  
    $VirtualMachines = Get-AzVM -ResourceGroupName $ResourceGroup.ResourceGroupName  
    foreach($VirtualMachine in $VirtualMachines)  
    {  
        $VMInfo = Get-AzVM -ResourceGroupName $ResourceGroup.ResourceGroupName -Name $VirtualMachine.Name -Status  
        foreach ($Status in $VMInfo.Statuses)  
        {   
          
            if($Status.Code -like "PowerState/*")  
            {  
                $VMDetails = $Status.DisplayStatus  
            }  
        }  
        $VMName = $VirtualMachine.Name     
    Write-Host "VM Name : $VMName    -----  $VMDetails "  
        $Body = $Body + " <br /> VM Name : $VMName    -----  $VMDetails "   
    }  
}#outer for 



  
$Body = $Body + " VM STATUS ARE  : $VMName   " 

write-host "pushing to mail"

$SMTPServer = "smtp.gmail.com"
$SMTPPort = "25"
$SMTPPort = "587"
$Username = "raviteja.idams134@gmail.com"
$Password = Read-Host 'What is your password?' -AsSecureString

$to = "ravitejapatel567@gmail.com"
#$cc = "user2@domain.com"
$subject = "VMSTATUS  info"
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


   