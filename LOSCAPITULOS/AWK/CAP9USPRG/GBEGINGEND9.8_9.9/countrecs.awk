BEGIN {
       printf"Reacords are :  \n\n"
       c=0
       tot=0
      }

     {
       c++;
       
       tot += $3

       printf "%2d %5d %-10s %5d %-10s %-10s c=%2d subtot=%9.2f\n", NR,$1,$2,$3,$4,$5,c,tot
     }
     END{
         printf "\n\t The Number Of Records Are:   \t%d\n",c
         printf "\n\t The Total Balance is:\t       %9.2f\n",tot
         printf "\n\t The Average Balance Is:   \t%.2f\n",tot/c
      }
