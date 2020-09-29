#reverse of a number


$num=1234

$temp
$revno=0


while($num -ne 0)
{

$temp=$num%10
$revno = ($revno*10)+$temp
write-host $revno
[int]$num/=10

}

Write-Host $revno