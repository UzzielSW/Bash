{
 start=7
 n=index($0,"WASHINGTON D C")
if ( n > 0 )
 {
   print $0
   exit
 }
if ( NR >=start )
    print $0
}
