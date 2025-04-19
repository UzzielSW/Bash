clear
echo " The following script prints all the words that are 
four characters long and which have occurred five or more
time.
"
echo wordsoccur.awk
cat wordsoccur.awk
echo
awk -f wordsoccur.awk  mat.lst
