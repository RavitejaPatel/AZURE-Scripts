Clear-Variable -name count 
$num=Read-Host
$Global:count



for($i=1;$i -le $num;$i++)
{

if($num%$i -ceq 0)
{
$count=$count+1
}

}

if($count -eq 2)
{
write-host $num "prime"
}
else
{
write-host $num "not prime"
}