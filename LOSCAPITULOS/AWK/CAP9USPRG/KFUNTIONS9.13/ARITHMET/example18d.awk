clear
echo "This example will print the result 3 as int() truncates the decimals from result. "
echo
awk 'BEGIN {
       print int(10/3) 
      }'
