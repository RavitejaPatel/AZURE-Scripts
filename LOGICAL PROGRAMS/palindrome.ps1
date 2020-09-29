

#palindrome of a number


$num=Read-Host
$actno=$num

$temp
$revno=0


while($num -ne 0)
{

$temp=$num%10
$revno = ($revno*10)+$temp
write-host $revno
$num= [Math]::Truncate($num/10)


}

if($revno -ceq $actno)
{
Write-Host "no is palindrome"
}
else
{
write-host "not palindrome"
}

