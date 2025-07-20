#! /bin/bash

show_promedio() {
  # calcular el promedio de las notas de los estudiantes
  echo -e "\nCalcular el promedio de las notas de los estudiantes:\n"
  awk '{ promedio = ($5 + $6) / 2; print "-", $0, "Promedio:", promedio }' data.lst
  echo ""
}

show_promedio
