clear
cat bank.lst
echo "Busca el patron /current/ en el  archivo: bank.lst"
echo "Lista las lineas que tienen el patron" 
echo
awk '/current/{ print }' bank.lst
