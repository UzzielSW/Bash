clear
cat bank.lst
echo
echo "Muestra todos los registros que tienen 
20 como dígito inicial y 09 como dígito final
en el cuarto campo \$4 del archivo bank.lst    "
awk ' $4 ~ /^20.*09$/ ' bank.lst
