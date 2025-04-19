echo " The following script replaces all the ocurrences 
of the pattern tea or Tea its upper case format, that is, TEA 
in the given file. "
echo shp.lst
cat shp.lst
echo reupper.awk
cat reupper.awk
awk -f reupper.awk shp.lst
