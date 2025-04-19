clear
cat bank.lst
echo "Busca el patron \$5 ~/^s/  en el  archivo: bank.lst"
echo "Lista las lineas que tienen el patron  que se busca" 
echo
awk ' $5 ~/^s/ ' bank.lst
