clear
cat bank.lst
echo "Busca el patron \$2 ~ "^A"  en el  archivo: bank.lst"
echo "Lista las lineas que tienen el patron  que se busca" 
echo
awk ' $2 ~"^A" ' bank.lst
