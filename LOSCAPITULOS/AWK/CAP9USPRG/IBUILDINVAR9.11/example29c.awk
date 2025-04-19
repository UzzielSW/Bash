clear
echo "  Imprime sólo el tercer registro,
es decir, se mostrará el registro número 3.     "
echo
awk 'NR == 3{ print NR,$0}' bank.lst
echo
