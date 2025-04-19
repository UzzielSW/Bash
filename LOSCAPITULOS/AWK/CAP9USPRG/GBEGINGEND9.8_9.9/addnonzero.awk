$3==0{next}
     {
      total +=$3
      count++
      printf "%2d %5d %-10s %5d %-10s %-10s count=%2d subtot=%9.2f\n", NR,$1,$2,$3,$4,$5,count,total
     }
     END { avrg = total/count
           printf "Total Amount\t       : %d\n",total
	   printf "Number Of Customer     : %d\n", count
           printf "Average Amount In Bank : %4.2f\n", avrg
         }
