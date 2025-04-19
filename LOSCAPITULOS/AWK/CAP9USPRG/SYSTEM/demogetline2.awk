BEGIN{
      "date" | getline
     print($1,$6)
    while("who" | getline)
      print($1,$2)
    }
