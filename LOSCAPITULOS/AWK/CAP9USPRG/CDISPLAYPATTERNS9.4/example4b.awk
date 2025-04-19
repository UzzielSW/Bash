clear
cat bank.lst
echo "Busca el patron /current/ en el  archivo: bank.lst"
echo "Se puede omitir las comillas /current/ "
echo "Lista las lineas que tienen el patron" 
echo
awk /current/ bank.lst
