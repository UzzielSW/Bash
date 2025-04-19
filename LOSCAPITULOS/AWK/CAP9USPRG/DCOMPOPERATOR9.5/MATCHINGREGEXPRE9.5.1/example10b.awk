clear
cat bank.lst
echo "Busca el patron \$5 !~/current/  en el  archivo: bank.lst"
echo "Lista las lineas que no tienen el patron  " 
echo
awk ' $5 !~/current/ ' bank.lst
