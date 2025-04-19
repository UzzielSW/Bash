clear
echo "El siguiente script cuenta el número de líneasi
y las palabras en cada línea y al final imprime el 
número total de líneas y palabras en el archivo text.lst.      "
echo
awk -f counttotlw.awk  text.lst
echo
