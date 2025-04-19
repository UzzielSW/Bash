clear
cat bank.lst
echo
echo  "totalbal31.awk suma el tercer campo \$3 de cada linea "
echo
awk -f totalbal31.awk bank.lst
echo
