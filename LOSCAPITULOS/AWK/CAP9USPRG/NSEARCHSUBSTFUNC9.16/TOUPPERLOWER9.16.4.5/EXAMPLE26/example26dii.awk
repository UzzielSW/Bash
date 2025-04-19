clear
echo " The following changes the case of the words
in the file into lower case."
echo text.lst
echo
cat text.lst
echo
cat intolower.awk
echo
awk -f intolower.awk text.lst
