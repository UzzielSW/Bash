clear
echo "Busca el patron \$3 > 10000  en el  archivo: bank.lst"
echo "Lista las lineas que tienen el patron  que se busca" 
echo
awk ' $3 > 10000 ' bank.lst
