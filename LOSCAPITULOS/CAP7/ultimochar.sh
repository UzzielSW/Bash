file=exec.o
echo $file
# lastchar=`echo $file | sed 's/.*\(.\)$/\1/'`
lastchar=$(echo $file | sed 's/.*\(.\)$/\1/')
echo $lastchar