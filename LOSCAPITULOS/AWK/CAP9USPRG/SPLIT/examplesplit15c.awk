clear
echo "The script prints the salary and then the name 
of person, interchanging the first name and surname
after removing the, (comma) from name: "
echo
echo salary.lst
echo
cat salary.lst
echo
echo salinterchange.awk
echo
cat salinterchange.awk
echo
awk -f salinterchange.awk salary.lst
