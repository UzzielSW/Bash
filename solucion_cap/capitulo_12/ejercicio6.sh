#!/bin/bash

: '
 Funcion substring: Remueve patrones desde ambos lados (izquierdo y derecho) de un valor
 utilizando las funciones leftmatch y rightmatch. Aplica ambas operaciones secuencialmente.

 Uso: substring patron_izquierdo valor patron_derecho
 Parametros:
   patron_izquierdo - patron shell a remover del lado izquierdo del valor
   valor - secuencia de uno o mas caracteres
   patron_derecho - patron shell a remover del lado derecho del valor

 Ejemplos:
   substring /usr/ /usr/spool/uucppublic /uucppublic  -> spool
   substring s. s.main.c .c                          -> main
   substring s. s.main.c .o                          -> main.c (solo coincide izquierda)
   substring x. s.main.c .o                          -> s.main.c (no coincide ninguno)
'

leftmatch() {
  if (($# != 2)); then
    echo "Error: Se requieren exactamente 2 argumentos" >&2
    return 1
  fi
  local pattern="$1"
  local value="$2"
  echo "${value#$pattern}"
}

rightmatch() {
  if (($# != 2)); then
    echo "Error: Se requieren exactamente 2 argumentos" >&2
    return 1
  fi
  local value="$1"
  local pattern="$2"
  echo "${value%$pattern}"
}

substring() {
  # Verificar numero de argumentos
  if (($# != 3)); then
    echo "Error: Se requieren exactamente 3 argumentos" >&2
    return 1
  fi

  local left_pattern="$1"
  local value="$2"
  local right_pattern="$3"

  # Aplicar leftmatch primero, luego rightmatch al resultado
  local temp_result
  temp_result=$(leftmatch "$left_pattern" "$value")
  rightmatch "$temp_result" "$right_pattern"
}

substring "$@"
