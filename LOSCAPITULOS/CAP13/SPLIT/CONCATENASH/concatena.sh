# splitfile9b
#if [ $(($# % 2 )) -eq 0 ]
#then
   #exec  < bookstore
   echo " Creando el archivo $3.dat "
   exec  5> $3.dat
exec 3< $1

 while read LINE 0<&3
 do
  echo "$LINE" 
 done>&5
exec  3<&-

exec 4< $2

 while read LINE 0<&4
 do
  echo "$LINE"  
 done>&5
exec  4<&-
exec  5<&-
 exec </dev/tty
 cat $3.dat
