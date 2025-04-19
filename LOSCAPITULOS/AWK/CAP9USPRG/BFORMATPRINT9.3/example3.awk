clear
echo "Lista con formato usando printf, los campo 1, 2, 3 del archivo: bank.lst"
awk '{ printf "%6d \t%-10s%-7d \n",$1,$2,$3 }' bank.lst
