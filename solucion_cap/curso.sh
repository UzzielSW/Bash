#! /bin/bash

# pasar info inicial a un archivo
: '
comentarios 
de varias
lineas. el espacio despues del : es obligatorio.
'

: ' Ejemplo de entrada por consola:
    echo -n "whats your name?"
    read NAME
    echo "hello $NAME!"
'

# al asignar valores a las variables no debe tener espacios
edad=12

#la estructura del if debe ser estrictamente asi
# -ge >=

if [ $edad -ge 18 ] 
then
    echo 'mayor'
else
    echo 'kid'
fi

number=0

echo "while"
while [ $number -lt 2 ]
do
    echo $number
    number=$(( number + 1))
done

echo "for con rangos"
for i in {0..1}
do
    echo $i
done

echo "for normal"
for ((i=0; i<3; i++))
do
    if [ $i -eq 2 ]
    then
        break
    fi

    echo $i
done

# para capturar los parametros que se ponen despues del nombre del programa al ejecutar el script.
# se usan $n siendo n el parametro en la posicion que se puso. $0 es la ruta del archivo
args=("$@0") #capturar todos los parametros, es una lista

echo "primer: ${args[0]}"

function crearFolder() {
    for i in {0..2}
    do
        mkdir "car $i"
    done
}

# crearFolder

echo "lista de user: "
list=( "jant" "tfs" )
for i in ${list[@]}  #el @ significa todos
do
    echo "$i"
done

# escribir salidas de comandos en una archivo:

# echo 'create y add info' > test.txt
# echo 'append info' >> test.txt
