#!/bin/bash
: "
 Script: ison
 Problema: El script original 'who | grep $1' encuentra coincidencias parciales
 en nombres de usuario. Por ejemplo, buscar "ed" encuentra "fred" porque
 "ed" está contenido en "fred".

 Solución: Usar grep con coincidencia exacta de palabra completa para que
 solo encuentre el usuario específico buscado.
"

# Verificar que se proporcione un argumento
if [ $# -eq 0 ]; then
    echo "Uso: $0 <nombre_usuario>" >&2
    exit 1
fi

# Buscar usuario con coincidencia exacta usando word boundary
# -w asegura que coincida solo con palabras completas
who | grep -w "$1"
