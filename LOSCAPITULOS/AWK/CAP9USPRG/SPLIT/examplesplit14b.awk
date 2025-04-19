clear
echo "It will split the first field($1) into parts
wherer the delimeter comma (,) appears and stores
those parts in the array p ( p[1] containing the first
part, p[2] containing the second part, and so on). After
splitting, the array p[2], containing the surname is
displayed, followed by a blank space, wich is then 
followed by the array p[1]. The names are displayed 
from the file salary.lst after interchanging the first name
and the surname."

echo "awk ' split(\$1,p,\",\") { print p[2] " " p[1] } ' salary.lst"
echo
cat salary.lst
echo
awk ' split($1,p,",") { print p[2] " " p[1] } ' salary.lst
