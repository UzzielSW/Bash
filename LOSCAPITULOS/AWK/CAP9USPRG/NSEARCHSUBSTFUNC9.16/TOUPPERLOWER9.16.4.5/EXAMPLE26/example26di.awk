echo " The following  script change the case 
of the words in the file text.lst. The words starting 
with lower case are converted to upper case
and the words starting with upper case characters
are converted to lower case. "
echo
echo text.lst
echo
cat text.lst
echo
awk -f changecase.awk text.lst
