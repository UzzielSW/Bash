clear
echo "The following script prints each record
preceded by its record number and a colon, with
no extra blanka from the file cont.lst."
echo 
cat renumcolon.awk
echo
awk -f renumcolon.awk cont.lst
