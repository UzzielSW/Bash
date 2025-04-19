clear
echo "It displays all records starting from any character in the
range A to W in the file bnk.lst"
echo
awk  '
    
    $0 ~/^[A-W]/{ print NR,$0} 
   ' bnk.lst
   echo
