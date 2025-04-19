clear
echo " The following script displays the total
quantity of items sold by each salesman and,
 in the end, displays the grand total"

echo solsales.awk
cat solsales.awk
echo
awk -f solsales.awk  sales.lst
