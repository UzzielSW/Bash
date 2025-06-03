# Autor: [Brayan Puyol]
# Cedula: [8-944-708]

# Este script tiene las siguientes funcionalidades:
# 1. Si se le ingresa un nombre de archivo como argumento, realiza la validación de todas las direcciones MAC contenidas en el archivo.
# 2. Si se le ingresa una dirección MAC como argumento, realiza la validación únicamente de esa dirección MAC.
# 3. Si se ejecuta el script sin parámetros, solicita al usuario que ingrese una dirección MAC para validar.

# EXPLICACION:
# Este script lee un archivo línea por línea y valida si cada línea es una dirección MAC válida.

# Explicación de la expresión regular: ^([0-9A-Fa-f]{2}[:-]){5}([0-9A-Fa-f]{2})$

# - ^: Inicio de la cadena.
# - ([0-9A-Fa-f]{2}[:-]){5}: Cinco grupos de dos dígitos hexadecimales seguidos de un separador (: o -).
# - ([0-9A-Fa-f]{2}): Un grupo final de dos dígitos hexadecimales.
# - $: Fin de la cadena.

# El bucle 'while' lee el archivo línea por línea usando 'IFS= read -r mac'.
# - 'IFS=' asegura que se preserven los espacios en blanco al inicio/final de la línea.
# - 'read -r' evita que las barras invertidas se interpreten como caracteres de escape.
# - '|| [[ -n "$mac" ]]' asegura que se procese la última línea incluso si no termina con un salto de línea.

# Dentro del bucle:
# - La condición 'if' utiliza una expresión regular para validar el formato de la dirección MAC.
# - La expresión regular verifica seis grupos de dos dígitos hexadecimales separados por ':' o '-'.
# - Los caracteres '^' y '$' aseguran que toda la línea coincida con el patrón.

# Si la dirección MAC es válida, el script imprime un mensaje indicando que es válida.

# El '< "$1"' al final especifica el archivo de entrada que se debe leer.

#!/bin/bash

# Verifica si se proporcionó un argumento
if [ $# -ne 1 ]; then
    # Solicita al usuario que ingrese una dirección MAC
    read -p "Ingrese una dirección MAC para validar: " mac_input
    
    if [[ $mac_input =~ ^([0-9A-Fa-f]{2}[:-]){5}([0-9A-Fa-f]{2})$ ]]; then
        echo -e "$mac_input - [\e[32mOK\e[0m] MAC válida"
    else
        echo -e "$mac_input - [\e[31mX\e[0m] MAC no válida"
    fi
    exit 1
fi

# Si se proporciona una dirección MAC como argumento
if [[ $1 =~ ^([0-9A-Fa-f]{2}[:-]){5}([0-9A-Fa-f]{2})$ ]]; then
    echo -e "$1 - [\e[32mOK\e[0m] MAC válida"
    exit 0
fi

if [ ! -f "$1" ]; then
    echo -e "$1 - [\e[31mX\e[0m] MAC no válida"
    exit 1
fi

# Si se proporciona un archivo como argumento
while IFS= read -r mac || [[ -n "$mac" ]]; do
    if [[ $mac =~ ^([0-9A-Fa-f]{2}[:-]){5}([0-9A-Fa-f]{2})$ ]]; then
        echo -e "$mac - [\e[32mOK\e[0m] MAC válida"
    else
        echo -e "$mac - [\e[31mX\e[0m] MAC no válida"
    fi
done < "$1"