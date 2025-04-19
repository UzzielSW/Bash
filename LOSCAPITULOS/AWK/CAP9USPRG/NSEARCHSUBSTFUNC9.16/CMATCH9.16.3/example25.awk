clear
echo "The following script counts the number of customers with  type of accounts."
echo
echo bank1.lst
echo
cat bank1.lst
echo
echo Salida:

awk -f countcurrent2.awk bank1.lst
echo
