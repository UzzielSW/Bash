BEGIN{  
      print"Enter the word"
      getline c < "/dev/tty"
     }
{
 n=toupper($0)
 c=toupper(c)
 k=index(n,c)

 if ( k > 0 )
   {
    print NR, $0
   }
}
