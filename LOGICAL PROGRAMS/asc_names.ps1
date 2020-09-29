<#
$arr=@("raviteja","Arjun","Prathyusha")

$arr+="Shylaja"

$arr | Sort-Object -Descending


#>


$arr=@("raviteja","Arjun","Prathyusha")

$arr+="Shylaja"


$len=$arr.Length

for($i=0;$i -lt $len ; $i++)
{

for($j=$i+1;$j -lt $len-1 ; $j++)
{

if( ($arr[$i].CompareTo($arr[$j]) -gt 0)  )
{
write-host "====================" $arr[$i]

$swap=$arr[$i]
$arr[$i]=$arr[$j]
$arr[$j]=$swap

}


}

}#for


for($i=0;$i -lt $len ; $i++)
{
write-host $arr[$i]

}