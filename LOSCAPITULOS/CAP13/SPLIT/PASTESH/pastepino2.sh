# splitfile9b
#if [ $(($# % 2 )) -eq 0 ]
#then
   #exec  < bookstore
   exec  5> nuevo.dat
   FICHERO=nuevo.dat
   FICHERO1="$1"
   FICHERO2="$2"
   cantidad="$#"
  // exec  2> error
for var in "$@"
do
  echo " argumentos1: $#"
  if [ ! -s "$FICHERO" ]
then

    echo "El $FICHERO no tiene datos."

  segundo="$FICHERO2"

  cp "$FICHERO2" segundo.bak

  if [ -f "$FICHERO1" -a  -r "$FICHERO1" ]
  then
   echo " paste de los archivos ...$FICHERO1 $FICHERO2"
   exec 3< "$FICHERO1"
   while read LINE 0<&3
   do
  if [ -f "$FICHERO2" -a -r "$FICHERO2" ]
  then
      exec 4< "$FICHERO2"

      read LINE2 0<&4
      
        
       echo "$LINE$LINE2" 
   
      cat $FICHERO2 |  grep -v "$LINE2" > temp
      mv temp $FICHERO2

  else 
       echo "Sorry, $FICHER2 are not readable regular file " 
      # rm nuevo.dat
      # cat error
      # rm error
       exit 1
   fi
   done>&5
   exec  3<&-
   exec  4<&-
   exec  5<&-
  else 
       echo "Sorry, $FICHERO1 are not readable regular file " 
      # rm nuevo.dat
      # cat error
       
       exit 1
  fi
  shift 2
  if [ "$#" -eq 0 ]
   then
      break  3
  fi
else echo " El fichero  tiene datos"
  if [ "$#" -ne 0 ]
  then
    echo "argumentos: $#"
  solouno="$1"
  NUEVO="nuevo.dat"
  ULTIMO="nuevo.dat"
 exec 8<"$NUEVO" 
  exec 9>"$ULTIMO"
  cp $solouno solouno.bak
  else
       break;
  fi
  if [ -f "$FICHERO" -a  -r "$FICHERO" ]
  then
   echo " paste de los archivos ...$FICHERO $solouno"
   while read LINE3 
   do
  if [ -f "$solouno" -a -r "$solouno" ]
  then
      exec 7<&0
      exec 7< "$solouno"

      read LINE4 
      
        
     echo "$LINE3$LINE4" 
   
      cat $solouno |  grep -v "$LINE4" > temp
      mv temp $solouno

  else 
       echo "Sorry, $1 are not readable regular file " 
       #rm nuevo.dat
       #cat error
       #rm error
       exit 1
   fi
   done<&8 >&9
   exec  7<&-
  else 
       echo "Sorry, $1 are not readable regular file " 
      # rm nuevo.dat
      # cat error
       
       exit 1
  fi
  if [ "$#" -ne 0 ]
  then
   shift 1
  :
  else
       break 
  fi
fi
done
#exec  5<&-

 exec </dev/tty
 cat nuevo.dat
if [ $cantidad -eq 2 ]
then
 cp segundo.bak $segundo 
else 
 cp solouno.bak $solouno
 fi
# rm nuevo.dat
# rm error
exit 0
