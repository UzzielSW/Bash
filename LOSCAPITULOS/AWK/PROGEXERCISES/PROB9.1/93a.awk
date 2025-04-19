awk 'BEGIN{
     FS="\t"
     OFS="\t"
 total=0
# i=0
}
{
#for(i=1; i<=NR; i++)
if( $1  >=  105 )
    total +=1
}
END{
  if ( total > 0 )
    print total
}' school.lst 
