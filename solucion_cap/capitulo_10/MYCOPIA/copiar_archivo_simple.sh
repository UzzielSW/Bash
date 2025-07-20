#!/bin/bash
#
# Script unificado para copiar un archivo de una ubicacion a otra.
#
# Este script integra las variantes encontradas en los archivos:
#   - mycp
#   - mycp1
#   - mycp.pin
#   - mycpb
#
# Diferencias principales entre las versiones originales:
#   - Algunas versiones verifican la existencia del archivo fuente antes de copiar (mycp1, mycp.pin, mycpb), otras no (mycp).
#   - Los mensajes de error y codigos de salida varian ligeramente.
#   - El nombre del script cambia en el mensaje de uso.
#   - mycpb tiene un error en el mensaje de archivo fuente no existente (muestra el destino en vez del origen).
#
# Esta version implementa las mejores practicas:
#   - Verifica la cantidad de argumentos.
#   - Verifica la existencia del archivo fuente.
#   - Verifica si el archivo destino existe y pregunta antes de sobrescribir.
#   - Mensajes claros y codigos de salida consistentes.
#
# Uso: copiar_archivo_simple.sh origen destino

if [ "$#" -ne 2 ]; then
  echo "USO: copiar_archivo_simple.sh origen destino"
  exit 1
fi

from="$1"
to="$2"

# Verifica si el archivo fuente existe
if [ ! -f "$from" ]; then
  echo "$from no existe"
  echo "La copia no se efectuo"
  exit 3
fi

# Verifica si el archivo destino existe
if [ -f "$to" ]; then
  echo "$to ya existe ; rescribir (yes/no)?"
  read answer
  if [ "$answer" != yes ]; then
    echo "La copia no se efectuo"
    exit 2
  fi
fi

echo "Copiando $from en $to ..."
cp "$from" "$to"

if [ "$?" -eq 0 ]; then
  echo "La copia sucedio satisfactoriamente"
  exit 0
else
  echo "La copia fallo"
  exit 1
fi
