#!/bin/bash

# Verifica si se pasó un argumento
if [ $# -eq 0 ]; then
    echo "Uso: $0 <numero>"
    exit 1
fi

echo "El doble de $numero es $(($1 * 2))"
echo `($1 \* 2)`