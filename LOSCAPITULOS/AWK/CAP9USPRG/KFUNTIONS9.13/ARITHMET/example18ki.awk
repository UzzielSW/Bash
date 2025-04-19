clear
echo " This displays all the records having A as starting character and 7
as  the ending character in the file bnk.lst"
echo
cat bnk.lst
echo salida:
awk  '
    
    $0 ~/^.*7$/ 
   ' bnk.lst
   echo
