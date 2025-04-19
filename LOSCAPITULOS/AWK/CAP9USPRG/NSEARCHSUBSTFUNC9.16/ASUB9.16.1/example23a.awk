clear
echo "The following script replaces the word Tea
with the word Brooke Bond in a given file and
displays those lines where the replacement is
performed."
echo
echo "shp.lst"
cat shp.lst
echo
awk -f replaceword.awk shp.lst
echo
