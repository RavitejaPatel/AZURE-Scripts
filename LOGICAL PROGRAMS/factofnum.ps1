

$factno=Read-Host

$num=1

do{

$num=$num*$factno
$factno=$factno-1
}

while($factno -gt 0 );

write-host $num

