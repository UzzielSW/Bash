BEGIN{
       printf "Enter the account number: "
       getline act < "/dev/tty"
       printf "Enter balance: "
       getline bal < "/dev/tty"
       printf "Records of customers are:\n\n"
     }

       $1 > act && $3 > bal { printf "%5d %-10s %d\n",$1, $2, $3 }
