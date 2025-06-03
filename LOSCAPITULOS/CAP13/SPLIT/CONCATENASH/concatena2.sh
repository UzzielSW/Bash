# splitfile9b
#if [ $(($# % 2 )) -eq 0 ]
#then
   #exec  < bookstore
   exec  5> nuevo.dat
   exec  2> error
for var in "$@"
do
  if [ -f "$1" -a  -r "$1" ]
  then
   echo " Concatenando el archivo ...$1 "
   exec 3< $1

   while read LINE 0<&3
   do
     echo "$LINE" 
   done>&5
   exec  3<&-
  else 
       echo "Sorry, $1 are not readable regular file " >&2
       rm nuevo.dat
       cat error
       rm error
       exit 1
  fi
  shift
done
exec  5<&-
 exec </dev/tty
 cat nuevo.dat
 rm nuevo.dat
 rm error
exit 0
