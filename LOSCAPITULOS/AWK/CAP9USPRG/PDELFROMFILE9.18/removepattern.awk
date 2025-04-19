awk 'BEGIN{
           printf "Enter a word: "
           getline w < "/dev/tty"
           
           while (( getline k < "'$1'" ) > 0 )
             {
                n=index(k,w)
               
                if( n == 0)
                         print k > "'$1'"
           }
    }'
