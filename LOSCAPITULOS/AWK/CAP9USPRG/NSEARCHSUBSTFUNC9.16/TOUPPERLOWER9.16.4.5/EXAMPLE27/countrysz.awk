BEGIN{
      IFS="\t"
      OFS="\t"
      print "Num Row\tCountry\tArea\tPOP\tContinents"
     }
{
      h=substr($1,1,1)
  #    printf "\nNR = %d h=%c fila = %s\n",NR,h,$0
      if( ( h >= "S" && h <= "Z") || ( h >= "s" && h <= "z"))

            print NR,$1,$2,$3,$4
}

