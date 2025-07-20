clear
awk 'BEGIN{
      OFS="\t"
      FS="\t"
      #system("clear")
      print "Entre la fila inicio: "
      getline filaInc < "/dev/tty"
      print "Entre la fila final: "
      getline filaFin < "/dev/tty"
    }
{
 if ( NR >= filaInc && NR <= filaFin )
   {
     #printf "%-15s %-15s %-15s %-15s %d %d\n",  $1, $2, $3,$4,$5,$6
     print  NR,$1, $2, $3,$4,$5,$6
  }
}' dsfdasfdata.lst 
