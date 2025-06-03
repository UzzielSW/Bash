# splitfile9b
#if [ $(($# % 2 )) -eq 0 ]
#then
   #exec  < bookstore
 #  exec  5> nuevo.dat
   touch nuevo.dat
  
   FICHERO1="$1"
   exec  2> error
for var in "$@"
do
  echo " archivos = $@ "
  echo " argumentos1: $#"


  if [ -f "$FICHERO1" -a  -r "$FICHERO1" ]
  then

      paste nuevo.dat $FICHERO1 >nuevo2.dat 
   
  else 
       echo "Sorry, $FICHERO1 are not readable regular file " >2 
       rm nuevo.dat
       cat error
       
       exit 1
  fi
  if [  "$#" -ne 0 ]
then
	  
  cp nuevo2.dat nuevo.dat
  FICHERO1="$2"
  shift 1
else
     break
fi
 
done >&5
exec  5<&-

 exec </dev/tty
 
 cat nuevo.dat | sed 's/  *//r'
 rm nuevo2.dat
 rm nuevo.dat
# rm error
exit 0
