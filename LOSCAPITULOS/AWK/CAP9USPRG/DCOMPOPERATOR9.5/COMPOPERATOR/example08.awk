clear
echo "Busca el patron \$5 != "current" en el  archivo: bank.lst"
echo "Lista las lineas que tienen el patron  que se busca" 
echo
awk ' $5 != "current" ' bank.lst
