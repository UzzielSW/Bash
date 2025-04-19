clear
echo " Its prints a message, good, if the balance is ggreater than 10,000 
and otherwise prints bad(only the message,good or bad,will be displayed with no records).",
    echo
awk  '
   { 
     if ( $3 > 10000) 
	     printf "%2d %s %+15s\n", NR, $0, " good"
     else    printf "%2d %s %+15s\n", NR, $0, " bad "
   }' bank.lst
   echo
