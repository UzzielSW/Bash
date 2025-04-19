BEGIN {  
	OFS = "\t"
	print "Sales man Name\t Sales made"
      }

      { sumqty[$2] += $3 }

      END {
             print"Deleting sugar index entry"
	     delete sumqty["Sugar"]

	      for ( i in sumqty )
	      {
	       print i,":",sumqty[i]
	             gqty += sumqty[i]
              }

	  print "Grand Total Of Sales ", gqty
  }

