BEGIN{
      FS="\t"
      c=0
      printf "Code	A/C	Name	Qty	Sp\n"
}
/sales/ { c=c + 1; tot[1]+=$4; tot[2]+=$5; print NR, $0 }
END{
   printf "c = %d\n",c
   printf "total1: is: %8.3f total2 is : %8.3f \n",tot[1],tot[2]
 printf "Average Quantity is %8.3f And Average Selling Price is %8.3f \n",tot[1]/c,tot[2]/c
 }

