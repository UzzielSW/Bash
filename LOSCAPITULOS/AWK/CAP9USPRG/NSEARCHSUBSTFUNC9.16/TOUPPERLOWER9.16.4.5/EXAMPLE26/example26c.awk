clear
echo " The following script searches for a word 
in any case (lower case or upper case) in the file matter.lst
ands displays the matching lines."
echo
cat matter.lst
echo
awk -f searchword.awk matter.lst
echo
