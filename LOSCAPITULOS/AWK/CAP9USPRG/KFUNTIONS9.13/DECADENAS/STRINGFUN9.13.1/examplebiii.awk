clear
echo " El siguiente script imprime el número promedio de palabras por línea.
Primero, calcula el número total de líneas y el número total de palabras
en el archivo text.lst y luego imprime el promedio.    "
echo
awk -f avgwords.awk  text.lst
echo
