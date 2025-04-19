clear
echo "Busca el patron "current" en el \$5 campo en el  archivo: bank.lst"
echo "Lista las lineas que tienen el patron en el \$5 campo" 
echo
awk ' $5 == "current" ' bank.lst
