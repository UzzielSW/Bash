clear
echo " The following script displays the total
area and population in each of the continents
from the file cont.lst. Continent name is the 
first column, and the total area is the third column."
echo popareacont.awk
cat popareacont.awk
echo
awk -f popareacont.awk cont.lst
