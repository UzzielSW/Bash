#!/bin/bash

# ****************************************************************
# Programa: isyes
# Descripcion: Retorna codigo de salida 0 si el argumento es "yes"
#              en cualquier variacion (y, yes, Yes, YES, Y),
#              caso contrario retorna 1
# Ejemplo: isyes yes
# ****************************************************************

if [ "$#" -ne 1 ]; then
  echo "Error: Solo se debe ingresar un parámetro."
  echo "Uso: $0 <argumento>"
  exit 1
fi

# VERSION 1: Usando comando if
if [[ "${1,,}" =~ ^[y]([e][s])?$ ]]; then
  exit 0
else
  exit 1
fi
