clear
echo "Lista las  filas   NR  < 3  del archivo: bank.lst"
awk '   NR < 3    { print NR,$0 }' bank.lst
