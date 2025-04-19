BEGIN{ 
      print "Enter a character: "
      getline c < "/dev/tty"
     }
  {
   n=substr($0,1,1)
   
   n=toupper(n)
   c=toupper(c)
   if(n==c)
    {
     print NR, $0
    }
  }
