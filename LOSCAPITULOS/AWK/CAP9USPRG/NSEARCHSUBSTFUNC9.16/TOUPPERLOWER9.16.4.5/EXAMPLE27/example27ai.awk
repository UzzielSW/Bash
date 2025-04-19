clear
echo "The following script displays the countries of the Asian continent 
that have a population  of more  than 500 million."
#echo popasia.awk
#cat popasia.awk
echo
echo cont.lst
cat cont.lst
echo
awk -f popasia.awk cont.lst
echo
