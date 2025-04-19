clear
cat bank.lst
et nu
cho "Busca el patron \$5 ~/t$/  en el  archivo: bank.lst"
echo "Lista las lineas que tienen el patron  que se busca" 
echo
awk ' $5 ~/t$/' bank.lst
