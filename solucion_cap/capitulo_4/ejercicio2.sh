#!/bin/bash

# PROBLEMA:
# ¿Cual sera el efecto de los siguientes comandos?
# who | grep 'mary'
# who | grep '^mary'
# grep '[Uu]nix' ch?/*
# ls -l | sort +4n
# sed '/^$/d' text > text.out
# sed 's/\([Uu]nix\)/\1(TM)/g' text > text.out
# date | cut -c12-16
# date | cut -c5-11,25- | sed 's/\([0-9]\{1,2\}\)/\1,/'

# Imprimir explicaciones para cada comando
cat <<'EOF'
1. who | grep 'mary': Muestra las lineas de salida de 'who' que contienen 'mary' (en cualquier posicion)
2. who | grep '^mary': Muestra las lineas de salida de 'who' que comienzan con 'mary'
3. grep '[Uu]nix' ch?/*: Busca 'Unix' o 'unix' en todos los archivos de directorios que empiezan con 'ch' seguido de un caracter
4. ls -l | sort +4n: Lista archivos en formato largo y ordena por el quinto campo (tamano) numericamente (sintaxis antigua)
5. sed '/^$/d' text > text.out: Elimina lineas vacias del archivo 'text' y guarda en 'text.out'
6. sed 's/\([Uu]nix\)/\1(TM)/g' text > text.out: Reemplaza 'Unix' o 'unix' por 'Unix(TM)' o 'unix(TM)' en 'text' y guarda en 'text.out'
7. date | cut -c12-16: Muestra solo los caracteres 12-16 de la fecha actual (hora:minutos)
8. date | cut -c5-11,25- | sed 's/\([0-9]\{1,2\}\)/\1,/': 
   - cut: Extrae mes, dia y año (formato estandar)
   - sed: Anade comas despues de numeros (formatea fecha)
EOF
