{
 match($0,/[Tt]ea/)
 t=toupper(substr($0,RSTART,RLENGTH))
 printf "t=%-10s", t
 gsub(/[Tt]ea/,t)
print $0
}
