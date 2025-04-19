clear
echo " Muestra todos los registros donde
el segundo campo tiene más de cuatro caracteres.       "
echo
cat bank.lst
echo
awk ' length($2) > 4 { print NR, $0 }' bank.lst
echo " awk ' length(\$2) > 4 { print NR, \$0 }' bank.lst "
