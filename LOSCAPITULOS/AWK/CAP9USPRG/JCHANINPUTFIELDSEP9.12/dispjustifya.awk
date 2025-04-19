BEGIN { FS="|"} { 
                  printf " %-10s %5d  %-10s\n", $2,$3,$5
                }
