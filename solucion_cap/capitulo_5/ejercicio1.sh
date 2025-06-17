#!/bin/bash

# PROBLEMA:
# ¿Cuales de los siguientes son nombres de variables validos?
# XxXxXx
# _
# 12345
# HOMEDIR
# file.name
# _date
# file_name
# x0-9
# file1
# Slimit

# Lista de nombres a verificar
nombres=(
  XxXxXx
  _
  12345
  HOMEDIR
  file.name
  _date
  file_name
  x0-9
  file1
  Slimit
)

# Verificar cada nombre contra el patron de variable valida en Bash
# - Debe comenzar con letra o guion bajo
# - Solo puede contener letras, numeros y guiones bajos
for nombre in "${nombres[@]}"; do
  if [[ "$nombre" =~ ^[a-zA-Z_][a-zA-Z0-9_]*$ ]]; then
    echo "$nombre"
  fi
done
