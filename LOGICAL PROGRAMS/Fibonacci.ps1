

$a=0;
$b=1;
$c=$a+$b
$num=Read-Host

Write-Host $a 
Write-Host $b

while($c -le $num)
{
Write-Host $c

$a=$b
$b=$c
$c=$a+$b

}


