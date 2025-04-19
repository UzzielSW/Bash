clear

awk 'BEGIN { printf "Records in the bank.lst file are: \n"
          }
{ printf "%-6d %-10s %10d \n", $1, $2, $3 }' bank.lst
