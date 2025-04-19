BEGIN{
      FS="\t"
      totno=0
      tot=0
     }
{
  print $0
  totno +=$3
  if ( $2 >= 1998 )
    {
 #    print NR, $2,$3
      tot +=$3
    }
}
END {
     print "Total number of computers ", totno
     print "Total number of computers made after 1998 are ", tot
}
