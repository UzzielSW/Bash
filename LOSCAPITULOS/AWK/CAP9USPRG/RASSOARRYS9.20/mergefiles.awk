BEGIN {
	while ((getline f < "bank.lst") > 0 && (getline s < "shp.lst" ) > 0 )
        {

        print f,s
        }


	while ((getline f < "bank.lst") > 0  )
        {

        print f
        }
	while ( (getline first < "shp.lst" ) > 0 )
        {

        print s
        }
     }
