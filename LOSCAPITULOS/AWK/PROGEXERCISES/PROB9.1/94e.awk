awk 'BEGIN {
      i=0
     } 

{
   if( $2 == "Sharma" )
     { i++;  printf "\n%d %-10s %-10s %-10s %-10s %-10s %d %d\n",NR, $1, $2, $3, $4, $5,$6,$7 }
}
' data.lst
