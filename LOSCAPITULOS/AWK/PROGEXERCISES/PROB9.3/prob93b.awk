BEGIN{ i=0}
 { 
   if( $1 >= 105)
     {
    	i = i + 1
     print NR,$0
     }
}
END { print "Se encontraron a: ", i;
 }
