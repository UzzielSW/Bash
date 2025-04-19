clear
echo " The following script demostrates how item
can be deleted from array.First the total quantity
of each item is computed and stored in an array, and
then an element is deleted from an array.
"
echo delarray.awk
cat delarray.awk
echo
awk -f delarray.awk  shp.lst
