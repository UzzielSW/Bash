clear
echo "Imprime todos los registros del archivo
que tiene un número de registro> 0. Dado que
el número de registro comienza en 1, 
se muestran todos los registros del archivo bank.lst. "
awk 'NR >0' bank.lst
