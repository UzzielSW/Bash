clear
cat data.lst
awk 'BEGIN {
      i=0
      FS="\t"
      OFS="\t"
      print "Salida: "
     } 

{
    gsub(/science\t/,"commerce",$0)
   # if( index($0,"commerce"))
 #    i++;  printf "\n%d %-15s %-15s %-15s %d %d\n",i, $1, $2, $3, $4, $5 
   print  $0
}
' data.lst
