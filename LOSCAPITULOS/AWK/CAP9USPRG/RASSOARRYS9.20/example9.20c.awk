clear
echo " The following script displays the total
quantity of each item sold and in the end it also
displays the grand total"

echo soldqty.awk

awk -f soldqty.awk  shp.lst
