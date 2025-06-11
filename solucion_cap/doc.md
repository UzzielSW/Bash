# Este script despliega cuantos usuarios estan en el sistema
# sort -u (elimina duplicados)
can=`who | sort -u | wc -l`
echo "Fecha: $(date), en el sistema hay $can usuarios"

echo "Nombre de los usuarios en el sistema:"
who | cut -d' ' -f1

--------------------------------------------------------------------------------------------
# capitulo9: Calcula el factorial de un entero
if [ "$#" -ne 1 ]
then
    echo "USO: <comando> <cantidad> | <cantidad> debe ser menor a 20"
    exit 1
fi

n="$1"
echo  "$n" | grep "^[0-9][0-9]*$" > /dev/null

if [ "$?" -ne 0 ]
then
    echo "Introdujo caracteres o un valor invalido"
    exit 1
fi

fact=1
while [ "$n" -ne 0 ]
do
    fact=$(( fact * n ))
    n=`expr $n - 1`
done

echo "El factoria de $1! es: $fact"