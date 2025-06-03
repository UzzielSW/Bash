# Autor: [Brayan Puyol]
# Cedula: [8-944-708]

# Este script tiene las siguientes funcionalidades:
# 1. Si se le ingresa un nombre de archivo como argumento, realiza la validación de todas las direcciones IP contenidas en el archivo.
# 2. Si se le ingresa una dirección IP como argumento, realiza la validación únicamente de esa dirección IP.
# 3. Si se ejecuta el script sin parámetros, solicita al usuario que ingrese una dirección IP para validar.

# EXPLICACION:
# Este script lee un archivo línea por línea y valida si cada línea es una dirección IPv4 válida.

# El bucle 'while' lee el archivo línea por línea usando 'IFS= read -r ip'.
# - 'IFS=' asegura que se preserven los espacios en blanco al inicio/final de la línea.
# - 'read -r' evita que las barras invertidas se interpreten como caracteres de escape.
# - '|| [[ -n "$ip" ]]' asegura que se procese la última línea incluso si no termina con un salto de línea.

# Dentro del bucle:
# - La condición 'if' utiliza una expresión regular para validar el formato de la dirección IP.
# - La expresión regular verifica cuatro octetos separados por puntos, donde cada octeto es:
#   - Un número entre 0-255.
#   - '25[0-5]' coincide con números del 250 al 255.
#   - '2[0-4][0-9]' coincide con números del 200 al 249.
#   - '[01]?[0-9][0-9]?' coincide con números del 0 al 199.
# - Los caracteres '^' y '$' aseguran que toda la línea coincida con el patrón.

# Si la dirección IP es válida, el script imprime un mensaje indicando que es válida.

# El '< "$1"' al final especifica el archivo de entrada que se debe leer.

#!/bin/bash

# Verifica si se proporcionó un argumento
if [ $# -ne 1 ]; then
    # Solicita al usuario que ingrese una dirección IP
    read -p "Ingrese una dirección IP para validar: " ip_input
    
    if [[ $ip_input =~ ^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$ ]]; then
        echo -e "$ip_input - [\e[32mOK\e[0m] IP válida"
    else
        echo -e "$ip_input - [\e[31mX\e[0m] IP no válida"
    fi
    exit 1
fi

# Si se proporciona una dirección IP como argumento
if [[ $1 =~ ^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$ ]]; then
    if [[ $1 =~ ^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$ ]]; then
        echo -e "$1 - [\e[32mOK\e[0m] IP válida"
    fi
    exit 0
fi

if [ ! -f "$1" ]; then
    echo -e "$1 - [\e[31mX\e[0m] IP no válida"
    exit 1
fi

# Si se proporciona un archivo como argumento
while IFS= read -r ip || [[ -n "$ip" ]]; do
    if [[ $ip =~ ^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$ ]]; then
        echo -e "$ip - [\e[32mOK\e[0m] IP válida"
    else
        echo -e "$ip - [\e[31mX\e[0m] IP no válida"
    fi
done < "$1"