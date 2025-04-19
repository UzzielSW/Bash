clear
cat bank.lst
echo "Lista las  filas entre  NR  >= 3 && NR <= 7  del archivo: bank.lst"
echo
awk 'NR >= 3 && NR <= 7  { print NR, $0 }' bank.lst
echo
