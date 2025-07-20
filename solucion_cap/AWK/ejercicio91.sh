#!/bin/bash

# Problema: Analisis de archivo stock.lst con comandos AWK
# El archivo contiene: codigo_producto nombre_producto precio cantidad categoria
# Datos de ejemplo:
# 102 Jeans 1000 10 garments
# 102 Camera 5000 3 electronics
# 103 Trousers 1200 5 garments
# 104 Laptop 40000 15 electronics
# 105 CellPhone 8000 8 electronics

# Crear archivo de prueba stock.lst
create_stock_file() {
  cat >stock.lst <<'EOF'
102 Jeans 1000 10 garments
102 Camera 5000 3 electronics
103 Trousers 1200 5 garments
104 Laptop 40000 15 electronics
105 CellPhone 8000 8 electronics
EOF
}

# Verificar existencia del archivo
check_file() {
  if [[ ! -f "stock.lst" ]]; then
    echo "Archivo stock.lst no encontrado. Creando archivo de prueba..."
    create_stock_file
  fi
}

# Ejecutar comandos AWK y mostrar resultados
run_awk_commands() {
  echo "=========================================="
  echo "ANALISIS DE ARCHIVO stock.lst CON AWK"
  echo "=========================================="

  # a) Buscar lineas que contengan 'garments'
  echo "a) awk '/garments/' stock.lst"
  echo "   Busca lineas que contengan 'garments':"
  awk '/garments/' stock.lst
  echo ""

  # b) Buscar 'electronics' y mostrar columna 2 y 4
  echo "b) awk '/electronics/ { print \$2 ,\$4 }' stock.lst"
  echo "   Busca 'electronics' y muestra nombre y cantidad:"
  awk '/electronics/ { print $2 ,$4 }' stock.lst
  echo ""

  # c) Filtrar registros donde columna 4 < 10
  echo "c) awk '\$4 <10' stock.lst"
  echo "   Muestra registros donde cantidad < 10:"
  awk '$4 <10' stock.lst
  echo ""

  # d) Mostrar numero de linea y contenido completo
  echo "d) awk 'NR >0 { print NR, \$0 }' stock.lst"
  echo "   Muestra numero de linea y contenido completo:"
  awk 'NR >0 { print NR, $0 }' stock.lst
  echo ""

  # e) Mostrar lineas 2 a 4 con numero de linea
  echo "e) awk 'NR == 2, NR == 4 { print NR, \$0 }' stock.lst"
  echo "   Muestra lineas 2 a 4 con numero de linea:"
  awk 'NR == 2, NR == 4 { print NR, $0 }' stock.lst
  echo ""

  # f) Mostrar numero de linea y numero de campos
  echo "f) awk '{ print NR, NF }' stock.lst"
  echo "   Muestra numero de linea y numero de campos:"
  awk '{ print NR, NF }' stock.lst
  echo ""

  # g) Mostrar numero de linea y ultimo campo
  echo "g) awk '{ print NR, \$NF }' stock.lst"
  echo "   Muestra numero de linea y ultimo campo:"
  awk '{ print NR, $NF }' stock.lst
  echo ""

  # h) Buscar registros donde columna 5 termine en 's'
  echo "h) awk '\$5 ~/s\$/' stock.lst"
  echo "   Busca registros donde categoria termine en 's':"
  awk '$5 ~/s$/' stock.lst
  echo ""

  # i) Buscar registros donde columna 2 comience con 'C'
  echo "i) awk '\$2 ~ \"^C\"' stock.lst"
  echo "   Busca registros donde nombre comience con 'C':"
  awk '$2 ~ "^C"' stock.lst
  echo ""

  # j) Buscar registros donde columna 2 comience con 'C' Y columna 4 < 5
  echo "j) awk '\$2 ~ \"^C\" && \$4 < 5' stock.lst"
  echo "   Busca registros donde nombre comience con 'C' Y cantidad < 5:"
  awk '$2 ~ "^C" && $4 < 5' stock.lst
  echo ""
}

# Funcion principal
main() {
  check_file
  run_awk_commands
}

# Ejecutar script
main
