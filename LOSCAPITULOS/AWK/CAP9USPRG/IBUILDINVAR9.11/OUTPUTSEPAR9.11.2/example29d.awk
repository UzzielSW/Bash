clear
echo "Imprime el primer, segundo y tercer campo 
del archivo bank.lst. Los campos estarán separados 
por un espacio de tabulación. OFS significa separador
de campo de salida. En ausencia de OFS, el separador
de campo de salida predeterminado es un espacio en blanco.     "
echo
awk 'BEGIN { OFS="\t"} 
    { print $1, $2, $3 } ' bank.lst
    echo
