clear
echo bank.lst
cat bank.lst
echo "           "
echo "Imprime todos los registros que tienen
A como carácter inicial en el segundo campo,
o t como carácter final en el quinto campo.
\$2 ~"^A" || \$5 ~ "t\$"
Se muestran los registros que satisfacen
una de estas  condiciones debido al operador or (||). "
echo
awk ' $2 ~ "^A" || $5 ~ "t$"  ' bank.lst
