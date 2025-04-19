clear
echo "The following script replaces the string Tea
with Brooke Bond in the whole file. "
echo
echo shp.lst
cat shp.lst
echo
awk -f replstrglob.awk shp.lst
echo
