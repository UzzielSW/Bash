BEGIN {  
       FS=" "
      }

      { split($0,k)
	# all the words are stored in a array k

	      for ( i in k)
	      {
	              j[k[i]]++
	#counting the freaquency of each word and storing in the array j 
              }
       }

      END {
	      for ( i in j )
	      {
		 if ( length(i) == 4 && j[i] >= 5 )
	       print i,"\t",j[i]
              }

  }
