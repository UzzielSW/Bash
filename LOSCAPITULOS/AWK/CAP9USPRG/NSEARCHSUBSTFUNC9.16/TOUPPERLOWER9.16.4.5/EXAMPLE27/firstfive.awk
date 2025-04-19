BEGIN{
      IFS="\t"
      OFS="\t"
      print "Country\tArea\tPOP\tContinents"
     }
{
  if(  NR <= 5 )
      print NR,$1,$2,$3,$4
}

