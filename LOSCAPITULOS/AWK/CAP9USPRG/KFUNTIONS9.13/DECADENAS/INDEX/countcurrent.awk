{
   n=index($0,"current")
   if ( n > 0 )
    {
      c++
    }
}
END { print " The number of customers with current account is ", c
}

