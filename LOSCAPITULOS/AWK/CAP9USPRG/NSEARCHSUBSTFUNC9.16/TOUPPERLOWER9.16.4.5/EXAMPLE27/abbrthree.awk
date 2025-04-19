BEGIN{
      FS="\t"
      OFS="\t"
      print "Country\tArea\tPOP\tContinents"
     }
{
      h=substr($1,1,3)
       h = toupper(h)   
      print h,$2,$3,$4
}

