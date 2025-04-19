clear
echo
awk 'BEGIN { printf "Records in the bank.lst file are: \n"
          }
{ print $1,"\t",$2,$3 }' bank.lst
