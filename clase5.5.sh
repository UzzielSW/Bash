#!/bin/bash

# Ejercicio 1 - Captitulo 8

if [ "$#" -ne 1 ]; then
  echo "Error: Solo se debe ingresar un parámetro."
  echo "Uso: $0 <cadena>"
  exit 1
fi

cad="$1"

# Convirtiendo a minúsculas: ${cad,,}"
case "${cad,,}" in
y | yes) echo "yes" ;;
*) echo "no" ;;
esac
