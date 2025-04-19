clear
echo "The following script prints each line
of the file in reverse order. Reverse, here, 
does not mean upside down; instead, it means
that the first word of the line is printed last,
, the second word is printed second las, and so on."
echo reversefile.awk
echo
 cat reversefile.awk
 echo text.lst
 cat text.lst
echo
awk -f reversefile.awk text.lst
