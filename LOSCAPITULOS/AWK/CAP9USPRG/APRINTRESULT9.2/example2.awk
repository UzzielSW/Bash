clear
cat bank.lst
echo
echo "Lista los campo 1, 2, 3 del archivo: bank.lst"
awk '{ print $1,$2,"\t",$3 }' bank.lst
echo
