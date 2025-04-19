clear
cat bank.lst
echo "Busca el patron /current/ en el  archivo: bank.lst"
echo "Se puede referir a la linea completa con \$0"
echo "Lista las lineas que tienen el patron" 
echo
awk '/current/{ print $0 }' bank.lst
