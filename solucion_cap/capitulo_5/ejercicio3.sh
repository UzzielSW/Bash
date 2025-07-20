#!/bin/bash

# PROBLEMA:
# Escribe un programa llamado nf que muestre el numero de archivos en tu directorio actual.

# Este script cuenta todos los archivos (incluyendo directorios y archivos ocultos)
# excluyendo los directorios especiales '.' (actual) y '..' (padre)

# Usamos un contador inicializado en 0
contador=0

# Recorremos todos los elementos en el directorio actual, incluyendo ocultos
for elemento in * .*; do
  # Saltamos los directorios especiales '.' y '..'
  [[ "$elemento" == "." || "$elemento" == ".." ]] && continue
  # Verificamos si el elemento existe (para manejar casos de globs no expandidos)
  [[ -e "$elemento" ]] && ((contador++))
done

# Mostramos el contador final
echo "Forma 1: $contador"

# ----------------------------------------------------
# forma simple
echo -n "Forma 2: "
ls -A | wc -l
