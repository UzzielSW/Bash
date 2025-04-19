BEGIN{
       printf "Enter the a/c no: "
       getline act < "/dev/tty"
       printf "Records of customers are:\n\n"
     }

       $1 > act { printf "\t%d %-10s %10.2f %-10s %-10s\n",$1, $2, $3, $4, $5 }
