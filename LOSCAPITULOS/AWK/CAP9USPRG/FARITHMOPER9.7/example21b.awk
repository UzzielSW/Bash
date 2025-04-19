clear
cat bank.lst
echo 
echo "Despliega el nombre del cliente, el saldo, 
la fecha y el interés (5% del saldo)
cuyo quinto campo es: \$5 == "saving".    "
echo
awk '$5 == "saving" {  printf "%2d\t%-10s%-5d\t%-10s%8.2f\n",NR,$2,$3,$4,$3*0.05 } ' bank.lst
