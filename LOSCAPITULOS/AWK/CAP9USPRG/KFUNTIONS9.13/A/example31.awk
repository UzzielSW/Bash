clear
echo "El siguiente script imprime primero el valor mayor
seguido del valor menor de los dos valores
(de cada línea/registros) en el archivo dado (usando la función).    "
echo "data.lst"
cat data.lst
echo
 awk -f largersmaller.awk data.lst
 echo
