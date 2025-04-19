clear
echo " The following script displays the records of the customers having
and account number greater than the value entered by the user. "
echo
cat bank.lst
echo
awk -f desiredact.awk bank.lst
echo
