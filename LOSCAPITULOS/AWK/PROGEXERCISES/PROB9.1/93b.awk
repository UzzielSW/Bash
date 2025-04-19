awk 'BEGIN{
FS="\t"
OFS="\t"
i=0
}
{
  if( $3 == "commerce" )
      i++
}
END {print "Commerce son: ", i} '  data.lst
