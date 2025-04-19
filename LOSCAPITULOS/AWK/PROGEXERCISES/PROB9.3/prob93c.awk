 awk ' $3 == "science" && $1 <= 103 { i++} ; END {print i}' school.lst
