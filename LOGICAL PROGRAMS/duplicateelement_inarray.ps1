

$arr=@()
$arr=(1,9,3,1,3,1)
$len=$arr.Length
$reptNO=@()

write-host "======================"

for($i=0;$i -lt $len ;$i++)
{
for($j=$i+1;$j -lt $len-1 ;$j++)
{
if($arr[$i] -ceq $arr[$j])
{
$reptNO+=$arr[$j]
}

}
}
