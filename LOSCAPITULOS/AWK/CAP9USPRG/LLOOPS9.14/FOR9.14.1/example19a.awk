clear
echo "Its display each record of the file bank.lst two times."
echo
awk '{ for (k=1; k <= 2; k++) printf "%s\n", $0}' bank.lst
echo
