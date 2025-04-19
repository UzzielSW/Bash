clear
echo "The following script will copy all
lines (records) of the file bank.lst and
store them in another file bkw.lst."
echo copylines.awk
cat copylines.awk
echo
awk -f copylines.awk 
echo "cat bkw.lst"
cat bkw.lst
