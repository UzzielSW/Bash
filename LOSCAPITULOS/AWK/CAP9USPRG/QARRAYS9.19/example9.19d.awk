clear
echo "The following script prints average quantity and average sales price, that is,
the quantities and prices of sold items are added and then divided by number of records added. "
echo avgqtysp.awk
cat avgqtysp.awk
echo
echo shop.lst
cat shop.lst
echo
awk -f avgqtysp.awk shop.lst
