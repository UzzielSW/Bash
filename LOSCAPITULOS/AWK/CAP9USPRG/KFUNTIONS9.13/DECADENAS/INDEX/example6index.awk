clear
echo " El siguiente script cuenta el número de clientes con cuenta corriente      "
cat bank.lst
echo
cat countcurrent.awk
echo
awk -f countcurrent.awk bank.lst
echo
