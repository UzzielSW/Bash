clear
cat bankpin.lst
echo "Busca el patron '\$5 ~ "[Cc]urrent"'  en el  archivo: bank.lst"
echo "Lista las lineas que tienen el patron  que se busca" 
echo
awk ' $5 ~ "[Cc]urrent" ' bankpin.lst
