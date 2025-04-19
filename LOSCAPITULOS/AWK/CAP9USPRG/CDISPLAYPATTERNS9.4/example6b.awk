clear
echo "Busca el patron /saving/ en el  archivo: bank.lst"
echo "Usando printf, Lista los campos \$2,\$3,\$4  de cada "
echo "linea que tienen el patron" 
echo
awk '/saving/ { printf "%-10s %-5d \t%-10s \n", $2,$3,$4 }' bank.lst
