#filename="$1"
for filename in "$@"
do
  lineCount="1"
  while IFS="\n" read line
   do
     echo "${lineCount}: $line"
     lineCount="$(( $lineCount + 1))"
   done < $filename
done
exit 0
