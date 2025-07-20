#!/bin/bash

# Problema: Scripts AWK para contar estudiantes en archivo school.lst
# El archivo contiene: roll nombre carrera nota1 nota2 total
# Datos de ejemplo:
# 101 Anil science 45 60 105
# 102 Rama commerce 55 30 85
# 103 Sunil science 35 20 55
# 104 Peter commerce 75 70 145
# 105 Sanjay science 95 80 175

# Crear archivo de prueba school.lst
create_school_file() {
  cat >school.lst <<'EOF'
101 Anil science 45 60 105
102 Rama commerce 55 30 85
103 Sunil science 35 20 55
104 Peter commerce 75 70 145
105 Sanjay science 95 80 175
EOF
}

# Verificar existencia del archivo
check_file() {
  if [[ ! -f "school.lst" ]]; then
    echo "Archivo school.lst no encontrado. Creando archivo de prueba..."
    create_school_file
  fi
}

# Ejecutar conteos con AWK
run_awk_counting() {
  echo "================================================================="
  echo "CONTEO DE ESTUDIANTES EN ARCHIVO school.lst CON AWK"
  echo "================================================================="

  # a) Contar estudiantes con roll >= 105
  echo "a) Contar estudiantes con roll >= 105:"
  echo "   Comando: awk '\$1 >= 105 { count++ } END { print \"Estudiantes con roll >= 105:\", count+0 }' school.lst"
  awk '$1 >= 105 { count++ } END { print "Estudiantes con roll >= 105:", count+0 }' school.lst
  echo ""

  # b) Contar estudiantes de commerce
  echo "b) Contar estudiantes de commerce:"
  echo "   Comando: awk '\$3 == \"commerce\" { count++ } END { print \"Estudiantes de commerce:\", count+0 }' school.lst"
  awk '$3 == "commerce" { count++ } END { print "Estudiantes de commerce:", count+0 }' school.lst
  echo ""

  # c) Contar estudiantes de science con roll <= 103
  echo "c) Contar estudiantes de science con roll <= 103:"
  echo "   Comando: awk '\$3 == \"science\" && \$1 <= 103 { count++ } END { print \"Estudiantes de science con roll <= 103:\", count+0 }' school.lst"
  awk '$3 == "science" && $1 <= 103 { count++ } END { print "Estudiantes de science con roll <= 103:", count+0 }' school.lst
  echo ""

  # d) Contar estudiantes con total >= 100
  echo "d) Contar estudiantes con total >= 100:"
  echo "   Comando: awk '\$6 >= 100 { count++ } END { print \"Estudiantes con total >= 100:\", count+0 }' school.lst"
  awk '$6 >= 100 { count++ } END { print "Estudiantes con total >= 100:", count+0 }' school.lst
  echo ""

  # Mostrar resumen de todos los conteos
  echo "================================================================="
  echo "RESUMEN DE CONTEOS:"
  echo "================================================================="

  # Script combinado para mostrar todos los conteos
  awk '
   BEGIN {
       roll_count = 0
       commerce_count = 0
       science_roll_count = 0
       total_count = 0
   }
   {
       # Contar roll >= 105
       if ($1 >= 105) roll_count++

       # Contar commerce
       if ($3 == "commerce") commerce_count++

       # Contar science con roll <= 103
       if ($3 == "science" && $1 <= 103) science_roll_count++

       # Contar total >= 100
       if ($6 >= 100) total_count++
   }
   END {
       print "- Estudiantes con roll >= 105:", roll_count
       print "- Estudiantes de commerce:", commerce_count
       print "- Estudiantes de science con roll <= 103:", science_roll_count
       print "- Estudiantes con total >= 100:", total_count
       print "- Total de estudiantes en el archivo:", NR
   }
   ' school.lst
}

# Funcion principal
main() {
  check_file
  run_awk_counting
}

# Ejecutar script
main
