clear
cat text.lst
echo
echo "Despliega el numero de linea y cuenta la cantidad de campos NF del archivo: text.lst"
echo "Es decir, cuenta cuantas palabras tiene por linea"
awk '   { print "linea: " NR,"campos: ", NF }' text.lst
