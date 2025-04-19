clear
echo " The following script counts the frequency
of every word in the file letter.lst ."
echo countfreq.awk

awk -f countfreq.awk letter.lst
