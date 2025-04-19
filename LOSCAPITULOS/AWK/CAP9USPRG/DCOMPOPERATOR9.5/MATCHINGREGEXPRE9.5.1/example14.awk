clear
cat bankpin.lst
echo "Busca el patron '\$5 ~/saving/'  en el  archivo: bankpin.lst"
echo "Lista las lineas que tienen el patron  que se busca" 
echo
awk ' $5 ~/saving/ ' bank.lst
