clear
echo "Estas declaraciones imprimen todos los registros
del archivo bank.list junto con el número de registro
(número de línea). La variable incorporada,
NR, representa el número de fila o registro y $0 
representa la línea de entrada completa. "
awk 'NR >0{ print NR,$0}' bank.lst
