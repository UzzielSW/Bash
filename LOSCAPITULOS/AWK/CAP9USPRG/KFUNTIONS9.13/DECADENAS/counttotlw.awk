BEGIN { print "Line No\t Words \t Line"}
{
 print NR, "\t", NF,"\t" $0
w +=NF
}

END {
     print "\n Totals: "
     print "Words: \t" w
     print "Lines: \t" NR
    }
