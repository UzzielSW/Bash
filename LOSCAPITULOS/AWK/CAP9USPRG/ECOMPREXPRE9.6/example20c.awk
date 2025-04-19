clear
echo "Lista las  filas   NR  == 3 ||  NR == 5  del archivo: bank.lst"
awk 'NR == 3 || NR == 5  { print NR, $0 }' bank.lst
