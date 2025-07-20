#!/bin/bash

: '
 Implementacion del comando wc en shell utilizando ${#var} para contar caracteres.
 Cuenta lineas, palabras y caracteres de la entrada estandar o archivos especificados.

 Utiliza:
 - ${#var} para obtener el numero de caracteres en una variable
 - IFS configurado solo a newline para preservar espacios iniciales
 - read -r para ignorar backslashes al final de linea
 - Aritmetica entera para todos los calculos
'

# Inicializar contadores usando aritmetica entera
declare -i total_lines=0
declare -i total_words=0
declare -i total_chars=0

# Guardar IFS original para restaurarlo despues
IFS_original="$IFS"

# Funcion para procesar entrada y contar lineas, palabras y caracteres
count_input() {
  local filename="$1"
  declare -i lines=0
  declare -i words=0
  declare -i chars=0
  local line

  # Establecer IFS solo a newline para preservar espacios iniciales
  IFS=$'\n'

  # Leer linea por linea usando -r para ignorar backslashes terminales
  while read -r line; do
    # Incrementar contador de lineas
    ((lines++))

    # Contar caracteres en la linea (incluyendo espacios iniciales)
    # Sumar 1 por el caracter newline que read no incluye
    ((chars += ${#line} + 1))

    # Contar palabras: restaurar IFS temporalmente para dividir palabras
    IFS="$IFS_original"
    set -- $line    # Dividir linea en palabras usando $@
    ((words += $#)) # $# contiene el numero de parametros (palabras)
    IFS=$'\n'       # Restaurar IFS a newline
  done

  # Si hay entrada pero no termina en newline, ajustar contador de caracteres
  # (esto se maneja automaticamente por como read funciona)

  # Mostrar resultados
  if [ -n "$filename" ]; then
    printf "%8d %8d %8d %s\n" "$lines" "$words" "$chars" "$filename"
  else
    printf "%8d %8d %8d\n" "$lines" "$words" "$chars"
  fi

  # Actualizar totales
  ((total_lines += lines))
  ((total_words += words))
  ((total_chars += chars))
}

# Restaurar IFS
IFS="$IFS_original"

# Procesar argumentos
if [ $# -eq 0 ]; then
  # Leer de entrada estandar
  count_input
else
  # Procesar cada archivo
  for file in "$@"; do
    if [ -f "$file" ]; then
      count_input "$file" <"$file"
    elif [ -r "$file" ]; then
      count_input "$file" <"$file"
    else
      echo "wc: $file: No such file or directory" >&2
      continue
    fi
  done

  # Mostrar totales si se procesaron multiples archivos
  if [ $# -gt 1 ]; then
    printf "%8d %8d %8d total\n" "$total_lines" "$total_words" "$total_chars"
  fi
fi

# Restaurar IFS original
IFS="$IFS_original"
