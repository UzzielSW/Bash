clear
echo
awk 'BEGIN {
      i=0
       print NR, $0 
      printf "Enter the range1: "
      getline a1 < "/dev/tty"
      printf "Enter the range2: "
      getline a2 < "/dev/tty"
     } 

{
   if( a1 <= NR &&  NR <= a2 )
     { i++;  printf "\n%d %-10s %-10s %-10s %-10s %-10s %d %d\n",NR, $1, $2, $3, $4, $5, $6,$7 }
}
' data.lst
