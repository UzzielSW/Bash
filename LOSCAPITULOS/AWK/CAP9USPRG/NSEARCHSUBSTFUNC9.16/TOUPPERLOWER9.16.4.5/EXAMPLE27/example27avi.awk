clear
echo " The following script prints the contents 
of the file countries abbreviating the country
names to their first three characters from the
file cont.lst." 
echo abbrthree.awk
cat abbrthree.awk
echo
awk -f abbrthree.awk cont.lst
