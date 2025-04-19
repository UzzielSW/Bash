awk ' BEGIN{
IFS="\t"
OFS="\t"
i=0
}
{
  if( $3 == "commerce" )
      i++
}
END {print "Commerce son: ", i}' school.lst
