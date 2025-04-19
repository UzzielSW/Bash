{
 t = gsub(/Tea/,"Brooke Bond",$0)
}

{
  if ( t > 0 )
    print NR, $0
#  else print NR,"no hay"
}
