clear
echo "It displays all the records not starting from any character in the range A to W
in the file bnk.lst"
echo
awk  '
    
    $0 !~/^[A-W]/{ print NR,$0} 
   ' bnk.lst
   echo
