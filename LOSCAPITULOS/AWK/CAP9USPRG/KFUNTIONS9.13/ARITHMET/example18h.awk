clear
echo "Its prints 1 (because sin PI/2 =1) 10 times
because there are 10 records/lines in the file bank.lst   "
echo
awk  'BEGIN{
       PI = 3.1415926
      }
   { 
       print  NR, sin(90*PI/180)
   }' bank.lst
