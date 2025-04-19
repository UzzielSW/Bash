clear
echo "It prints the squqre root of the balance of the file bank.lst"
echo
awk ' {
       print   sqrt($3)
      }' bank.lst
