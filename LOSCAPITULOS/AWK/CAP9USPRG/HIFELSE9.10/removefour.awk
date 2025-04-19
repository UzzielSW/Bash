echo "Todas las líneas del archivo bank.lst
se copiarán en el archivo bkk.lst 
excepto las primeras cuatro líneas. "
archivo=$1
echo "$archivo" | grep -w "bkk.lst" > /dev/null

if [ "$#" -ne 1 -o "$?" -ne 0 ]
then
    echo "Error"
    echo "USO: $0 bkk.lst"
    exit 1
fi
 awk 'NR > 4 { print $0 > "'$archivo'" }' bank.lst
 cat  $archivo
