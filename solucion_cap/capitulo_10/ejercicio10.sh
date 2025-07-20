#!/bin/bash

: '
 PROBLEMA:
 Modificar el script 'lu' para usar printf para imprimir el nombre y numero de telefono
 de manera que se alineen en columnas para nombres de hasta 40 caracteres de longitud.
 Usar cut -f aprovechando que los campos en la agenda telefonica estan separados por tabs.
'

# Verificar que se proporciono un argumento de busqueda
if [ $# -eq 0 ]; then
  echo "Uso: $0 <nombre_a_buscar>"
  exit 1
fi

# Buscar en la agenda telefonica y formatear la salida
grep "$1" phonebook | while IFS=$'\t' read -r nombre telefono resto; do
  # Usar printf para alinear en columnas: nombre hasta 40 caracteres, telefono a la derecha
  printf "%-40s %s\n" "$nombre" "$telefono"
done

# Verificar si no se encontraron resultados
if ! grep -q "$1" phonebook 2>/dev/null; then
  echo "No se encontro '$1' en la agenda telefonica"
  exit 1
fi
