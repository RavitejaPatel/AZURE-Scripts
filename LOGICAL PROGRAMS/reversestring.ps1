

$str="hello world"

$len=$str.Length
$revstr=@()


for($i=($len-1) ; $i -ge 0 ; $i--)
{



write-host $i "===================" $str[$i]


$revstr+=$str[$i];
}

write-host $revstr

