#!/bin/bash

: "
 Funcion rightmatch: Remueve el patron mas corto que coincida desde el lado derecho
 del valor proporcionado. Si no hay coincidencia, devuelve el valor original.

 Uso: rightmatch valor patron
 Parametros:
   valor - secuencia de uno o mas caracteres
   patron - patron shell a remover del lado derecho del valor

 Ejemplos:
   rightmatch test.c .c          -> test
   rightmatch /usr/spool/uucppublic '/*'  -> /usr/spool
   rightmatch /usr/spool/uucppublic o      -> /usr/spool/uucppublic
"

rightmatch() {
  # Verificar numero de argumentos
  if (($# != 2)); then
    echo "Error: Se requieren exactamente 2 argumentos" >&2
    return 1
  fi

  local value="$1"
  local pattern="$2"

  # Usar expansion de parametros con % para remover el patron mas corto desde la derecha
  # Si no hay coincidencia, devuelve el valor original
  echo "${value%$pattern}"
}

rightmatch "$@"
