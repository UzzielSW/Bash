#!/bin/bash

# Programa que valida si un argumento es un nombre valido de variable de shell
# Imprime "yes" si es valido, "no" en caso contrario
# Un nombre valido debe comenzar con letra o guion bajo, seguido de letras, numeros o guiones bajos

# Verificar que se proporciono exactamente un argumento
if [ $# -ne 1 ]; then
    echo "no"
    exit 1
fi

# Patron de expresion regular para nombre valido de variable:
# ^[a-zA-Z_][a-zA-Z0-9_]*$
# ^ - inicio de cadena
# [a-zA-Z_] - primer caracter debe ser letra o guion bajo
# [a-zA-Z0-9_]* - cero o mas caracteres alfanumericos o guiones bajos
# $ - final de cadena

if echo "$1" | grep -q '^[a-zA-Z_][a-zA-Z0-9_]*$'; then
    echo "yes"
else
    echo "no"
fi
