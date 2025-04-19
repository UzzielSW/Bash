clear
cat bank.lst
echo "Busca el patron /saving/ en el  archivo: bank.lst"
echo "Lista los campos \$2,\$3,\$4,\$5 de cada linea que tienen el patron" 
echo "Si no colocamos las comas los campos se desplegarian sin espacios  " 
echo
awk '/saving/ { print $2,$3,$4,$5 }' bank.lst
