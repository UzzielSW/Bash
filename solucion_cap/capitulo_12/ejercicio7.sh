#!/bin/bash

: '
 Funciones substring, leftmatch y rightmatch modificadas para soportar opciones
 que permiten remover coincidencias mas largas (greedy) o mas cortas (non-greedy)
 de los patrones especificados.

 Opciones disponibles:
   -g, --greedy     : Remueve la coincidencia mas larga posible (## y %%)
   -n, --non-greedy : Remueve la coincidencia mas corta posible (# y %) [por defecto]

 Uso:
   leftmatch [-g|-n] patron valor
   rightmatch [-g|-n] valor patron
   substring [-g|-n] patron_izquierdo valor patron_derecho

 Ejemplos mejor funcionales:
   leftmatch -g "*/" "/usr/bin/ls"        -> "ls"
   leftmatch -n "*/" "/usr/bin/ls"        -> "usr/bin/ls"
   rightmatch -g ".*" "file.tar.gz"       -> "file"
   rightmatch -n ".*" "file.tar.gz"       -> "file.tar"
'

leftmatch() {
  local greedy=false
  local pattern value

  # Procesar opciones
  while [[ $# -gt 0 ]]; do
    case $1 in
    -g | --greedy)
      greedy=true
      shift
      ;;
    -n | --non-greedy)
      greedy=false
      shift
      ;;
    -*)
      echo "Error: Opcion desconocida $1" >&2
      return 1
      ;;
    *)
      break
      ;;
    esac
  done

  # Verificar argumentos restantes
  if (($# != 2)); then
    echo "Error: Se requieren exactamente 2 argumentos despues de las opciones" >&2
    echo "Uso: leftmatch [-g|-n] patron valor" >&2
    return 1
  fi

  pattern="$1"
  value="$2"

  # Aplicar expansion segun el modo
  if [[ $greedy == true ]]; then
    echo "${value##$pattern}" # Coincidencia mas larga desde la izquierda
  else
    echo "${value#$pattern}" # Coincidencia mas corta desde la izquierda
  fi
}

rightmatch() {
  local greedy=false
  local value pattern

  # Procesar opciones
  while [[ $# -gt 0 ]]; do
    case $1 in
    -g | --greedy)
      greedy=true
      shift
      ;;
    -n | --non-greedy)
      greedy=false
      shift
      ;;
    -*)
      echo "Error: Opcion desconocida $1" >&2
      return 1
      ;;
    *)
      break
      ;;
    esac
  done

  # Verificar argumentos restantes
  if (($# != 2)); then
    echo "Error: Se requieren exactamente 2 argumentos despues de las opciones" >&2
    echo "Uso: rightmatch [-g|-n] valor patron" >&2
    return 1
  fi

  value="$1"
  pattern="$2"

  # Aplicar expansion segun el modo
  if [[ $greedy == true ]]; then
    echo "${value%%$pattern}" # Coincidencia mas larga desde la derecha
  else
    echo "${value%$pattern}" # Coincidencia mas corta desde la derecha
  fi
}

substring() {
  local greedy=false
  local left_pattern value right_pattern

  # Procesar opciones
  while [[ $# -gt 0 ]]; do
    case $1 in
    -g | --greedy)
      greedy=true
      shift
      ;;
    -n | --non-greedy)
      greedy=false
      shift
      ;;
    -*)
      echo "Error: Opcion desconocida $1" >&2
      return 1
      ;;
    *)
      break
      ;;
    esac
  done

  # Verificar argumentos restantes
  if (($# != 3)); then
    echo "Error: Se requieren exactamente 3 argumentos despues de las opciones" >&2
    echo "Uso: substring [-g|-n] patron_izquierdo valor patron_derecho" >&2
    return 1
  fi

  left_pattern="$1"
  value="$2"
  right_pattern="$3"

  # Aplicar leftmatch primero, luego rightmatch con la misma opcion
  local temp_result
  if [[ $greedy == true ]]; then
    temp_result=$(leftmatch -g "$left_pattern" "$value")
    rightmatch -g "$temp_result" "$right_pattern"
  else
    temp_result=$(leftmatch -n "$left_pattern" "$value")
    rightmatch -n "$temp_result" "$right_pattern"
  fi
}

# Ejecutar la funcion solicitada con los argumentos proporcionados
"$@"
