{
total=0
c=0
i=3
while(i <= NF)
{
total +=$i
c++
i++
}

if( c > 0  )
{
 avg = total/c
print($1,$2,avg)
}
}
