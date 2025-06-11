#!/bin/bash
: '
 Escribe un programa llamado twice que tome un unico argumento entero y duplique su valor:
 $ twice 15
 30
 $ twice 0
 0

 Manejando excepciones:
 1. ¿Qué ocurre si se escribe un valor no entero?
    Error: El argumento debe ser un numero entero
 2. ¿Qué ocurre si se omite el argumento?
    Error: Se requiere un argumento entero
'

# Funcion para manejar errores
error_exit() {
    echo "Error: $1" >&2
    exit 1
}

# Verificar si se proporcionó un argumento
if [ $# -ne 1 ]; then
    error_exit "Se requiere un argumento entero"
fi

# Verificar si el argumento es un numero entero
if ! [[ $1 =~ ^-?[0-9]+$ ]]; then
    error_exit "El argumento debe ser un numero entero"
fi

# Duplicar el valor del argumento
duplicado=$(($1 * 2))

# Imprimir el resultado
echo "$duplicado"
