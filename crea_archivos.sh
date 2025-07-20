#!/bin/bash

files=("feb96" "jan12.02" "jan19.02" "jan26.02" "jan5.02" "jan95" "jan96" "jan97" "jan98" "mar98" "memo1" "memo10" "memo2" "memo2.sv")
# Recorrer la lista y aplicar un comando a cada elemento
for file in "${files[@]}"; do
  echo "$(date) - contenido del archivo: $file" >$file
done
