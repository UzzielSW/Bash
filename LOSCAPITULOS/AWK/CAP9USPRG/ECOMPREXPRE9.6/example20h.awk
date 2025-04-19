clear
echo "bank.lst"
cat bank.lst
echo
echo "Imprime todos los registros que tienen
A como carácter inicial en el segundo campo,
así como t como carácter final en el quinto campo.
\$2 ~"^A" && \$5 ~ "t\$"
Solo se muestran los registros que satisfacen
ambas condiciones debido al operador and (&&). "
echo
awk ' $2 ~ "^A" && $5 ~ "t$"  ' bank.lst
