clear
echo bank.lst
cat bank.lst
echo "           "
echo "Imprime todos los registros que tienen
en el quinto campo /saving/ o /current/
o t como carácter final en el quinto campo.
\$5 ~ /saving/ || \$5 ~ /current/
Se muestran los registros que satisfacen
una de estas  condiciones debido al operador or (||). "
awk ' $5 ~ /saving/ || $5 ~ /current/ ' bank.lst
