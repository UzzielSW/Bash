{
 print $0, "\t", n=length($0)
 c +=n
}
END { print "Total characters in ", FILENAME, "are",c }
