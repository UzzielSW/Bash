clear
echo "This example will print the output 1 as sin(PI/2) is 1."
echo 
awk  'BEGIN{
       PI = 3.1415926
       print   sin(90*PI/180)
      }'
