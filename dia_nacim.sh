#!/bin/bash

# Verifica si se proporcionó una fecha como argumento
if [ -z "$1" ]; then
  echo "Uso: $0 AAAA-MM-DD"
  exit 1
fi

# Guarda la fecha del argumento
FECHA="$1"

# Intenta calcular el día de la semana
DIA=$(date -d "$FECHA" +%A 2>/dev/null) # 2>/dev/null oculta errores de formato

# Verifica si el comando date tuvo éxito
if [ $? -eq 0 ]; then
  echo "El dia de la semana que nacio fue un $DIA"
else
  echo "Error: Formato de fecha inválido '$FECHA'. Usa el formato AAAA-MM-DD."
  exit 1
fi

exit 0
