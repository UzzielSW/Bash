clear
cat bank.lst
echo "Lista las  filas   NR  < 2 ||  NR > 4  del archivo: bank.lst"
awk 'NR  < 2 || NR > 4  { print NR, $0 }' bank.lst
