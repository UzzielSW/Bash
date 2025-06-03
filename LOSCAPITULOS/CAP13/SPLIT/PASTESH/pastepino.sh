# splitfile9b
#if [ $(($# % 2 )) -eq 0 ]
#then
   #exec  < bookstore
   exec  5> nuevo.dat
   exec  2> error
#for var in "$@"
#do

  segundo="$2"
  cp $segundo segundo.bak
  if [ -f "$1" -a  -r "$1" ]
  then
   echo " paste de los archivos ...$1 $2"
   exec 3< "$1"
   while read LINE 0<&3
   do
  if [ -f "$2" -a -r "$2" ]
  then
      exec 4< "$2"

      read LINE2 0<&4
      
        
     echo "$LINE$LINE2" 
   
      cat $segundo |  grep -v "$LINE2" > temp
      mv temp $segundo

  else 
       echo "Sorry, $2 are not readable regular file " >&2
       rm nuevo.dat
       cat error
       rm error
       exit 1
   fi
   done>&5
   exec  3<&-
   exec  4<&-
  else 
       echo "Sorry, $1 are not readable regular file " >&2
       rm nuevo.dat
       cat error
       
       exit 1
  fi
#  shift 2
#done
exec  5<&-
 exec </dev/tty
 cat nuevo.dat
 cp segundo.bak $segundo 
# rm nuevo.dat
# rm error
exit 0
