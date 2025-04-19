clear
cat bank.lst
echo "Muestra todos los registros que tienen 
20 como dígito inicial y 09 como dígito 
inal en el cuarto campo del archivo bank.lst 
y N como carácter inicial en el segundo campo.
awk ' \$4 ~ /^20.*09\$/ && \$2 ~/^N/' bank.lst"
awk ' $4 ~ /^20.*09$/ && $2 ~/^N/' bank.lst
