BEGIN { FS="|"} { 
                  printf "%-10s %5d %-15s\n",$1, $2, $3
                }
