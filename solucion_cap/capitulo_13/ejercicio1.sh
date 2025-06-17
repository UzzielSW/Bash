#!/bin/bash

# Programa recho: Imprime los argumentos en orden inverso usando eval
# Ejemplo: recho one two three -> three two one
# Maneja mas de nueve argumentos correctamente

# Verificar si se pasaron argumentos
if [ $# -eq 0 ]; then
  exit 0
fi

# Construir la cadena de argumentos en orden inverso
output=""
for ((i = $#; i >= 1; i--)); do
  # Usar eval para acceder a los argumentos posicionales dinamicamente
  eval "arg=\$$i"
  if [ -n "$output" ]; then
    output="$output $arg"
  else
    output="$arg"
  fi
done

# Imprimir el resultado
echo "$output"
