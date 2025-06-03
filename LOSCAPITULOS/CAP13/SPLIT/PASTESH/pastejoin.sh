# splitfile9b
#if [ $(($# % 2 )) -eq 0 ]
#then
   #exec  < bookstore
  echo "los argumentos al inicio Son: $#: $@" 
  if [ -f "$1" -a  -r "$1" ]
  then
    cp "$1" primero.dat
    primero="$1"
    shift 1
fi
for var in "$@"
do
   exec  5> nuevo.dat
   nuevo=nuevo.dat
   exec  2> error
  echo "los argumentos dentro del for Son: $#:$@" 

  segundo="$1"
  cp $segundo segundo.back
  if [ -f primero.dat -a  -r primero.dat ]
  then
   echo " paste de los archivos ...$nuevo $1"
   exec 3< primero.dat
   while read LINE 0<&3
   do
  if [ -f "$1" -a -r "$1" ]
  then
      exec 4< "$1"

      read LINE2 0<&4
      
        
     echo "$LINE$LINE2" 
   
      cat $segundo |  grep -v "$LINE2" > temp
      mv temp $segundo

  else 
       echo "Sorry, $1 are not readable regular file " >&2
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
 mv segundo.back $segundo 
 cp primero.dat ${primero}

  shift
exec  5<&-
mv  nuevo.dat primero.dat
done
 exec </dev/tty
 
 cat nuevo.dat
 #cp segundo.bak $segundo 
 #cp primero.dat $primero
# m nuevo.dat
# rm error
exit 0
