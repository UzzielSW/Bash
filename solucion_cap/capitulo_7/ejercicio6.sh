#!/bin/bash

# Programa llamado 'suffix' que renombra un archivo agregando los caracteres
# dados como segundo argumento al final del nombre del archivo dado como
# primer argumento. Por ejemplo: suffix memo1 .sv renombra memo1 a memo1.sv

# Verificar numero de argumentos
if [[ $# -ne 2 ]]; then
    echo "Uso: $0 <archivo> <sufijo>" >&2
    exit 1
fi

archivo="$1"
sufijo="$2"

# Verificar que el archivo existe
if [[ ! -e "$archivo" ]]; then
    echo "Error: El archivo '$archivo' no existe" >&2
    exit 1
fi

# Validar que la extension no contiene caracteres no validos
if [[ "$2" =~ [^a-zA-Z0-9._-] ]]; then
    echo "Error: Extension '$2' contains invalid characters."
    exit 1
fi

# Verificar que el archivo de destino no existe para evitar sobrescribir
nuevo_nombre="${archivo}${sufijo}"
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
