clear
echo "The following scripts prints the first and last fields of the records
of the file address.lst: "
echo
cat address.lst
echo
echo Salida:
awk -f lastfield.awk address.lst
echo
