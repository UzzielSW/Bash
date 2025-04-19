clear
echo "The following script replaces a string with
another string of a particular record/line only."
 echo
 echo shp.lst
 cat shp.lst
 echo
awk -f replacestr.awk shp.lst
echo
