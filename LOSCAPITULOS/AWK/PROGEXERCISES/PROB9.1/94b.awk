clear
cat data.lst
awk 'BEGIN {
      i=0
     } 

{
   if( $3 == "Vaishali" && $4 ==  "Nagar" )
     { i++;  printf "\n%d %-10s %-10s %-10s %-10s %-10s %d %d\n",NR, $1, $2, $3, $4, $5,$6,$7 }
}
' data.lst
