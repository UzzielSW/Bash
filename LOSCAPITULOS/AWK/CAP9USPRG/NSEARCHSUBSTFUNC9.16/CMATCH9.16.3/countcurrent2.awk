BEGIN { 
	#type="term fixed"
	#type="[Cc]urrent"
	#type="saving"
	printf "Enter the account type: "
	getline type < "/dev/tty"
	c=0
        }
{

  # match($0,/[Cc]urrent/)
   match($0,type)
   if ( RSTART > 0 )
    {
      c++
    }
}
END { print " The number of customers with   ", type," account "," is ",c
}

