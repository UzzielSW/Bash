#!/bin/bash

: '
 Funcion leftmatch: Remueve el patron mas corto que coincida desde el lado izquierdo
 del valor proporcionado. Si no hay coincidencia, devuelve el valor original.

 Uso: leftmatch patron valor
 Parametros:
   patron - patron shell a remover del lado izquierdo del valor
   valor - secuencia de uno o mas caracteres

 Ejemplos:
   leftmatch /usr/spool/ /usr/spool/uucppublic  -> uucppublic
   leftmatch s. s.main.c                        -> main.c
'

leftmatch() {
  # Verificar numero de argumentos
  if (($# != 2)); then
    echo "Error: Se requieren exactamente 2 argumentos" >&2
    return 1
  fi

  local pattern="$1"
  local value="$2"

  # Usar expansion de parametros con # para remover el patron mas corto desde la izquierda
  # Si no hay coincidencia, devuelve el valor original
  echo "${value#$pattern}"
}

leftmatch "$@"
