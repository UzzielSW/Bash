clear
echo "Muestra la longitud (el número de caracteres)
de cada línea/registro del archivo text.lst   "
echo
cat text.lst
echo
awk '{ print length }' text.lst
echo
