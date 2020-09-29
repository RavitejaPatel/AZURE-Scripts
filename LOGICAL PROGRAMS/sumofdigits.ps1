



$num=Read-Host
$sum=0;
$temp

while($num -gt 0)
{
$temp=$num%10

write-host "==================" $temp,$sum

$sum=$sum+$temp
write-host "-----------"$sum


$num= [Math]::Truncate($num/10)
write-host "**********" $num


}
write-host $sum