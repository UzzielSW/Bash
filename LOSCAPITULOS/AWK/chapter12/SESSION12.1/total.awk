BEGIN {print "Print Totals"}
{total =  $1 +$2 + $3}
{print $1 " + " $2 " + " $3 " = " total}

END { print "End Totals"}
