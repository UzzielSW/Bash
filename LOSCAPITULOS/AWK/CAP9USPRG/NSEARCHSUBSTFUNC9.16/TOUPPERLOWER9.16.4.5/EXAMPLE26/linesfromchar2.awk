BEGIN{ 
	#system("clear")
	#system("cat letter.lst")
     {	print  } matter.lst
      print "Enter a character: "
      getline c < "/dev/tty"
     }
  {
    n=substr($0,1,1)

   if (  n >= "a" && n <= "z")
   { 
   n=toupper(n)
  }
   if (  c >= "a" && c <= "z")
   { 
   c=toupper(c)
   }
   if(n==c)
    {
     print NR, $0
    }
  }
