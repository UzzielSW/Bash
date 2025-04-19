clear
echo "The following script will copy all
lines (records) having the specified pattern
from a given file into another file.
 The file name will be passed
as command line arguments. "
echo
echo copypattern.awk
cat copypattern.awk 
echo
if [ "$#" -ne 1 ]
then
    echo "Error!"
    echo "USO: $0 bnkcur.lst"
    exit 1
fi
 copypattern.awk  $1
cat "$1"
