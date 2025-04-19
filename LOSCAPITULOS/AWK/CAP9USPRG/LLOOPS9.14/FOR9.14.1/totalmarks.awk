BEGIN{ print "Print Total\n"} 
      { print $0}
     { total = $3+$4+$5}
     { print $1,$2,$3"+"$4"+"$5"="total}
