clear
cat text.lst
echo
echo "Despliega el ultimo  campo \$NF  de cada linea del archivo: text.lst"
echo "Es decir, despliega la ultima  palabra  de cada linea"
echo
awk '   { print NR,$NF }' text.lst
