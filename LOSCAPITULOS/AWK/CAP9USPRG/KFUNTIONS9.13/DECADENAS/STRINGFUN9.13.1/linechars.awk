{
 print $0, "\t", n=length($0)
 c +=n
}
END { print "\nTotal characters in ", FILENAME, "are",c,"\n" }
