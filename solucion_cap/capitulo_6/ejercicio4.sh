#!/bin/bash

: '
Escribe los comandos para asignar las líneas únicas del archivo "names" 
a la variable de shell "namelist".
'

# Verificar que el archivo existe antes de procesarlo
if [[ ! -f "names" ]]; then
   echo "Error: El archivo 'names' no existe" >&2
   exit 1
fi

# Asignar líneas únicas del archivo a la variable namelist
# sort: ordena las líneas, -u: elimina duplicados adyacentes
# tr '\n' ' ': convierte saltos de línea en espacios para crear una lista
# más eficiente usando sort -u (combina sort y uniq)
namelist=$(sort -u "names" | tr -s '\12' ' ')

# Remover espacio final si existe
namelist=${namelist% }

echo "--------------------------------"
echo "Contenido del archivo names:"
echo "--------------------------------"
cat names
echo
echo "--------------------------------"
echo "Contenido de la variable namelist:"
echo "--------------------------------"
echo $namelist
echo "--------------------------------"
