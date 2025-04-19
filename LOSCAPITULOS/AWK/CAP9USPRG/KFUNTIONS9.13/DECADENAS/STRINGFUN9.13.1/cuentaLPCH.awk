 BEGIN { system("clear"); print "Line No\t Words \t Charaters \t Line" }
{
w +=NF
n=length($0)
c +=n
print NR, "\t", NF,"\t",n,"\t\t", $0
}
  
END {
print"\n\nTotal" 
print"Lines \t Words \t Charaters " 
print"____________________________\n"
print NR"\t", w,"\t",c,"\t\t"
print"____________________________"
print "\nTotals: ",FILENAME
print "Chars: \t"c 
print "Words: \t" w
print "Lines: \t" NR
print"____________________________\n"
    }
