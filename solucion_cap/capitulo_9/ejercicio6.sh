#!/bin/bash
: '
 wgrep: Busca un patron en un archivo, como lo hace grep, pero para cada linea
 que coincide, imprime una "ventana" alrededor de la linea coincidente. Es decir,
 imprime la linea anterior a la coincidencia, la linea coincidente y la linea
 siguiente a la coincidencia. Debe manejar correctamente los casos especiales
 donde el patron coincide con la primera linea del archivo y donde el patron
 coincide con la ultima linea del archivo.
'

# Verifica argumentos
if [[ $# -ne 2 ]]; then
  echo "USO: $0 patron archivo"
  exit 1
fi

pattern="$1"
file="$2"

# Verifica que el archivo existe y es legible
if [[ ! -f "$file" ]]; then
  echo "Error: $file no existe o no es un archivo regular"
  exit 1
fi

if [[ ! -r "$file" ]]; then
  echo "Error: No se puede leer el archivo $file"
  exit 1
fi

# Variables para el procesamiento
prev_line=""
current_line=""
next_line=""
line_num=0
total_lines=$(wc -l <"$file")
found_match=false

# Lee el archivo linea por linea
while IFS= read -r line || [[ -n "$line" ]]; do
  ((line_num++))

  # Desplaza las lineas: prev <- current <- next <- nueva_linea
  prev_line="$current_line"
  current_line="$next_line"
  next_line="$line"

  # Procesa desde la segunda iteracion (cuando tenemos current_line)
  if [[ $line_num -gt 1 ]]; then
    # Verifica si la linea actual coincide con el patron
    if [[ "$current_line" =~ $pattern ]]; then
      found_match=true

      # Imprime la linea anterior (si no es la primera linea del archivo)
      if [[ $line_num -gt 2 ]]; then
        echo "$prev_line"
      fi

      # Imprime la linea coincidente
      echo "$current_line"

      # Imprime la linea siguiente (si no es la ultima linea del archivo)
      if [[ $line_num -lt $total_lines ]]; then
        echo "$next_line"
      fi

      # Separador entre coincidencias
      echo "--"
    fi
  fi
done <"$file"

# Procesa la ultima linea (que quedo en next_line)
if [[ -n "$next_line" ]]; then
  current_line="$next_line"

  # Verifica si la ultima linea coincide con el patron
  if [[ "$current_line" =~ $pattern ]]; then
    found_match=true

    # Imprime la linea anterior (si existe)
    if [[ $total_lines -gt 1 ]]; then
      # Lee la penultima linea
      prev_line=$(sed -n "$((total_lines - 1))p" "$file")
      echo "$prev_line"
    fi

    # Imprime la linea coincidente (ultima linea)
    echo "$current_line"

    echo "--"
  fi
fi

# Codigo de salida
if [[ "$found_match" == true ]]; then
  exit 0
else
  exit 1
fi
