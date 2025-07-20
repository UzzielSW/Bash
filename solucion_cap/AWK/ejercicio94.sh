#!/bin/bash

# Problema: Scripts AWK para procesamiento de archivo data.lst con informacion de estudiantes
# El archivo contiene: nombre apellido direccion carrera nota1 nota2
# Datos de ejemplo:
# Anil Sharma Vaishali Nagar science 45 67
# Manoj Gupta SriNagar Road commerce 66 89
# Kamal Sharma Shastrii Nagar commerce 81 32
# Rama Sharma Vaishali Nagar commerce 45 91
# Chirag Harwani Vaishali Nagar science 34 63

# Crear archivo de prueba data.lst
create_data_file() {
  cat >data.lst <<'EOF'
Anil Sharma Vaishali Nagar science 45 67
Manoj Gupta SriNagar Road commerce 66 89
Kamal Sharma Shastrii Nagar commerce 81 32
Rama Sharma Vaishali Nagar commerce 45 91
Chirag Harwani Vaishali Nagar science 34 63
EOF
}

# Verificar existencia del archivo
check_file() {
  if [[ ! -f "data.lst" ]]; then
    echo "Archivo data.lst no encontrado. Creando archivo de prueba..."
    create_data_file
  fi
}

# Validar entrada numerica
validate_number() {
  local input=$1
  if [[ ! $input =~ ^[0-9]+$ ]]; then
    return 1
  fi
  return 0
}

# a) Mostrar lineas entre rango especificado por usuario
show_range() {
  echo "a) Mostrar lineas entre rango especificado:"
  echo "   Ingrese el numero de linea inicial:"
  read -r start_line
  echo "   Ingrese el numero de linea final:"
  read -r end_line

  # Validar entradas
  if ! validate_number "$start_line" || ! validate_number "$end_line"; then
    echo "   Error: Debe ingresar numeros validos"
    return 1
  fi

  if [[ $start_line -gt $end_line ]]; then
    echo "   Error: La linea inicial debe ser menor o igual a la final"
    return 1
  fi

  echo "   Comando: awk 'NR >= $start_line && NR <= $end_line' data.lst"
  awk "NR >= $start_line && NR <= $end_line" data.lst
  echo ""
}

# b) Mostrar registros con patron Vaishali Nagar
show_vaishali() {
  echo "b) Registros que contienen 'Vaishali Nagar':"
  echo "   Comando: awk '/Vaishali Nagar/' data.lst"
  awk '/Vaishali Nagar/' data.lst
  echo ""
}

# c) Reemplazar science con commerce
replace_science() {
  echo "c) Reemplazar 'science' con 'commerce':"
  echo "   Comando: awk '{ gsub(/science/, \"commerce\"); print }' data.lst"
  awk '{ gsub(/science/, "commerce"); print }' data.lst
  echo ""
}

# d) Mostrar contenido con total de dos asignaturas
show_with_total() {
  echo "d) Contenido del archivo con total de las dos asignaturas:"
  echo "   Comando: awk '{ total = \$5 + \$6; print \$0, \"Total:\", total }' data.lst"
  awk '{ total = $5 + $6; print $0, "Total:", total }' data.lst
  echo ""
}

# e) Mostrar registros con apellido Sharma
show_sharma() {
  echo "e) Registros con apellido 'Sharma':"
  echo "   Comando: awk '\$2 == \"Sharma\"' data.lst"
  awk '$2 == "Sharma"' data.lst
  echo ""
}

# Menu interactivo
show_menu() {
  echo "================================================================="
  echo "PROCESAMIENTO DE ARCHIVO data.lst CON AWK"
  echo "================================================================="
  echo "1. Mostrar lineas entre rango especificado"
  echo "2. Mostrar registros con 'Vaishali Nagar'"
  echo "3. Reemplazar 'science' con 'commerce'"
  echo "4. Mostrar contenido con total de asignaturas"
  echo "5. Mostrar registros con apellido 'Sharma'"
  echo "6. Ejecutar todas las opciones"
  echo "7. Salir"
  echo "================================================================="
}

# Ejecutar todas las opciones
run_all_options() {
  echo "================================================================="
  echo "EJECUTANDO TODAS LAS OPCIONES"
  echo "================================================================="

  # Ejecutar opciones automaticamente (excepto la interactiva)
  show_vaishali
  replace_science
  show_with_total
  show_sharma

  # Para la opcion de rango, usar valores por defecto
  echo "a) Mostrar lineas entre rango especificado (lineas 2-4):"
  echo "   Comando: awk 'NR >= 2 && NR <= 4' data.lst"
  awk 'NR >= 2 && NR <= 4' data.lst
  echo ""
}

# Funcion principal con menu
main() {
  check_file

  while true; do
    show_menu
    echo "Seleccione una opcion: "
    read -r option

    case $option in
    1) show_range ;;
    2) show_vaishali ;;
    3) replace_science ;;
    4) show_with_total ;;
    5) show_sharma ;;
    6) run_all_options ;;
    7)
      echo "Saliendo..."
      exit 0
      ;;
    *) echo "Opcion invalida. Intente nuevamente." ;;
    esac

    echo "Presione Enter para continuar..."
    read -r
  done
}

# Ejecutar script
main
