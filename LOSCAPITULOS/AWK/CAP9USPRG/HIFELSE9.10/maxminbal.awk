{
 if ( NR == 1 )
  {
   min=$3
   max=$3
   print "min1=",min,"  ","max1=",max
  }
 if ( max < $3 && NR != 1)
  {
   print NR,"max1=",max,"  ", $0
   max=$3
   print NR,"max1=",max,"  ", $0
  }
 if ( min > $3 && NR != 1)
   {
    print NR,"min2=",min,"  ", $0
    min=$3
    print NR,"min2=",min,"  ", $0
   }
}
END {
     print "Maximum balance is ", max
     print "Minimum balance is ", min
    }
