clear
echo "The following script prints all the records 
of the file bank.lst in reverse order."
echo reverserec.awk
cat reverserec.awk
echo
awk -f reverserec.awk bank.lst
