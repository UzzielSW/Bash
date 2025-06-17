: '
Autor: [Brayan Puyol]
Cedula: [8-944-708]

Este script tiene las siguientes funcionalidades:
1. Si se le ingresa un nombre de archivo como argumento, realiza la validación de todos los números de celular contenidos en el archivo.
2. Si se le ingresa un número de celular como argumento, realiza la validación únicamente de ese número.
3. Si se ejecuta el script sin parámetros, solicita al usuario que ingrese un número de celular para validar.

EXPLICACION:
Este script lee un archivo línea por línea y valida si cada línea es un número de celular válido en Panamá.

- La expresión regular verifica que el número:
  - Comience con '+507'.
  - Tenga un prefijo '6'.
  - Contenga 4 dígitos antes y después del guion.
- Los caracteres '^' y '$' aseguran que toda la línea coincida con el patrón.
'

#!/bin/bash

# Verifica si se proporcionó un argumento
if [ $# -ne 1 ]; then
    # Solicita al usuario que ingrese un número de celular
    read -p "Ingrese un número de celular para validar: " number_input
    
    if [[ "$number_input" =~ ^\+507\ [6][0-9]{3}-[0-9]{4}$ ]]; then
        echo -e "$number_input - [\e[32mOK\e[0m] Número válido"
    else
        echo -e "$number_input - [\e[31mX\e[0m] Número no válido"
    fi
    exit 1
fi

# Si se proporciona un número de celular como argumento
if [[ "$1" =~ ^\+507\ [6][0-9]{3}-[0-9]{4}$ ]]; then
    echo -e "$1 - [\e[32mOK\e[0m] Número válido"
    exit 0
fi

if [ ! -f "$1" ]; then
    echo -e "$1 - [\e[31mX\e[0m] Número no válido"
    exit 1
fi

# Si se proporciona un archivo como argumento
while IFS= read -r number || [[ -n "$number" ]]; do
    if [[ "$number" =~ ^\+507\ [6][0-9]{3}-[0-9]{4}$ ]]; then
        echo -e "$number - [\e[32mOK\e[0m] Número válido"
    else
        echo -e "$number - [\e[31mX\e[0m] Número no válido"
    fi
done < "$1"