{
 totw +=NF
 line++
 print $0
}
END {
     print "Total number of words in ", FILENAME, "are", totw
     print "Total number of lines are", line
     printf "Average number of words per line is %d\n", totw/line
} 
