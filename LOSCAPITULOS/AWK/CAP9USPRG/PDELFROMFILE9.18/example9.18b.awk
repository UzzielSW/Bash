clear
echo "The following script removes the lines 
with the specified pattern in file."
echo removepattern.awk
cat removepattern.awk
echo
if [ "$#" -ne 1 ]
then
   echo Error
   echo "USO: $0 bank.lst"
   exit 1
fi
removepattern.awk $1
