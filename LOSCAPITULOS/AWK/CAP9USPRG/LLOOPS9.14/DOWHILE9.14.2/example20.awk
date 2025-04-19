clear
echo "The following script prints the roll number, name, and average marks acquired
by each student (IInd method)."
echo scholl.lst
cat school.lst
echo

awk -f avgmarks2.awk school.lst
echo
