clear
echo "countrecs.awk cuenta los registros, es decir,
la cantidad de lineas, suma el total del 
tercer campo \$3 y calcula el promedio. "
awk -f countrecs.awk bank.lst
echo
