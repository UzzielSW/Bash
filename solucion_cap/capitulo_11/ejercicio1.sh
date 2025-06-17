#!/bin/bash

# Programa myrm que elimina archivos con confirmacion basada en MAXFILES
# Si MAXFILES esta definido, lo usa como maximo de archivos a eliminar sin preguntar
# Si no esta definido, usa 10 como maximo por defecto
# Si MAXFILES es 0, suprime la verificacion
# Si el numero de archivos excede el maximo, pide confirmacion al usuario

# Establecer el maximo de archivos (10 por defecto si MAXFILES no esta definido)
max_files=${MAXFILES:-10}

# Contar el numero de archivos a eliminar
file_count=$#

# Si no hay archivos especificados, salir
if [ $file_count -eq 0 ]; then
  echo "Usage: $0 <file1> [file2] ..." >&2
  exit 1
fi

# Si MAXFILES es 0, eliminar sin preguntar
if [ "$max_files" -eq 0 ]; then
  rm "$@"
  exit $?
fi

# Si el numero de archivos excede el maximo, pedir confirmacion
if [ $file_count -gt $max_files ]; then
  echo -n "Remove $file_count files (y/n)? "
  read response

  # Si la respuesta no es 'y' o 'Y', no eliminar
  if [ "${response,,}" != "y" ]; then
    echo "files not removed"
    exit 0
  fi
fi

# Eliminar los archivos
rm "$@"
