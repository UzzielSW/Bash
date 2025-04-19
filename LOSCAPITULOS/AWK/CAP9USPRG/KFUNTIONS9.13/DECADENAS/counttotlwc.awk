BEGIN { print "Line No\t Words \t characters"}
{
 print NR, "\t", NF,"\t" $0
w +=NF
c +=length($0)
c +=1
#print c
}

END {
     print "\n Totals: "
     print "Characters: \t" c
     print "Words: \t" w
     print "Lines: \t" NR
    }
