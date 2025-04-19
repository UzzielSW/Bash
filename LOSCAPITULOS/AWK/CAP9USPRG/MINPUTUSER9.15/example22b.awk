clear
echo "The following script displays the records of the customers having an account
number and balance greater than the values entered by the user. "
echo bank.lst
cat bank.lst
echo
awk -f actbal.awk bank.lst
echo
