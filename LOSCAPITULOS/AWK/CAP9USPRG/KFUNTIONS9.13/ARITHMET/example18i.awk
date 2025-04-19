clear
echo "It prints only the records with a balance 
(third field) less than 10,000 in the file bank.lst "
echo
awk  '
   { 
     if ( $3 < 10000)  print  NR, $0
   }' bank.lst
   echo
