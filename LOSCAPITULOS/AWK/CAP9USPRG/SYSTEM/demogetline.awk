BEGIN{
      "date" | getline
     print($1,$6)
    }
