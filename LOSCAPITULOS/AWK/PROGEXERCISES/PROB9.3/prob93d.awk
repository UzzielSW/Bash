awk ' $4 + $5 + $6 >= 100 { i++; print NR, $0 }; END { print i}' school.lst

