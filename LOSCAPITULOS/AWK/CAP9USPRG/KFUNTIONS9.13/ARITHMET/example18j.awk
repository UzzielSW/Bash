clear
echo " Its prints a message, good, if the balance is ggreater than 10,000 
and otherwise prints bad(only the message,good or bad,will be displayed with no records).",
    echo
awk  '
   { 
     if ( $3 > 10000)  print  NR, $0, "\t\tgood"; else print NR, $0, "\t\tbad"
   }' bank.lst
   echo
