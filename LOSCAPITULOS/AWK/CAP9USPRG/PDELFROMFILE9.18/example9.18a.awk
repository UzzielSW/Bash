clear
echo " The following script deletes lines from
a given file that does not have the specified
pattern."
echo delnotpattern.awk
cat bank.lst
echo
if [ "$#" -ne 1 ]
then
   echo "Error"
   echo "USO $0 bank.lst  "
   exit 1
fi
delnotpattern.awk $1
