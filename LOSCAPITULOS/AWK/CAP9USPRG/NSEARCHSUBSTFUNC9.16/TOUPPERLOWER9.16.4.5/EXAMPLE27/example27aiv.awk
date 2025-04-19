clear
echo "The following script prints those records
whose country name begins with the letters S to Z,
from  the file  cont.lst"
echo countrysz.awk
cat countrysz.awk
echo
awk -f countrysz.awk cont.lst
