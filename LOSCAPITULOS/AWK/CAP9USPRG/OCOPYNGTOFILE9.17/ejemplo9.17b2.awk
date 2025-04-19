clear
echo "The following script will copy all
lines (records) of one file and store them
in another file. The file name will be passed
as command line arguments. "
echo
if [ "$#" -ne 2 ]
then
    echo "Error!"
    echo "USO: $0 bank.lst bb.lst"
    exit 1
fi
band=0
if [ -e "$1" ]
then
   if [ -e "$2" ]
     then 
         echo "El archivo $2 EXISTE! "
         echo -n "Desea rescribir ( yes/ no ) ?: "
         read resp 
         if [ "$resp" = "y" ]
         then
#            copylines2.awk  $1 $2
	    band=1
        else
	echo "La copia no se ha realizado "
	 exit 2
        fi
   fi 
   copylines2.awk  $1 $2
   if [ $band -eq 0 ]
    then
        echo "$1 ha sido copiado en $2"
    else 
         echo "$2 ha sido rescrito"
    fi

    exit 0
else echo "bank.lst no existe"
     exit 3
fi
