#!/bin/bash

# Programa llamado 'unsuffix' que remueve los caracteres dados como segundo
# argumento del final del nombre del archivo dado como primer argumento.
# Por ejemplo: unsuffix memo1.sv .sv renombra memo1.sv a memo1
# Asegura que los caracteres se remuevan del final, por lo que
# unsuffix test1test test deberia renombrar test1test a test1

# Verificar numero de argumentos
if [[ $# -ne 2 ]]; then
    echo "Uso: $0 <archivo> <sufijo_a_remover>" >&2
    exit 1
fi

archivo="$1"
sufijo="$2"

# Verificar que el archivo existe
if [[ ! -e "$archivo" ]]; then
    echo "Error: El archivo '$archivo' no existe" >&2
    exit 1
fi

# Usar sed para remover el sufijo del final del nombre (escapar caracteres especiales)
sufijo_escapado=$(printf '%s\n' "$sufijo" | sed 's/[[\.*^$()+?{|]/\\&/g')
nuevo_nombre=$(printf '%s\n' "$archivo" | sed "s/${sufijo_escapado}\$//")

# Verificar que efectivamente se removio algo
if [[ "$nuevo_nombre" == "$archivo" ]]; then
    echo "Error: El archivo '$archivo' no termina con '$sufijo'" >&2
    exit 1
fi

# Verificar que el archivo de destino no existe
if [[ -e "$nuevo_nombre" ]]; then
    echo "Error: El archivo '$nuevo_nombre' ya existe" >&2
    exit 1
fi

# Renombrar el archivo
if mv "$archivo" "$nuevo_nombre"; then
    echo "Archivo renombrado: '$archivo' -> '$nuevo_nombre'"
else
    echo "Error: No se pudo renombrar el archivo" >&2
    exit 1
fi
