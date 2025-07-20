#!/bin/bash

# Problema: Comandos AWK para consultas especificas en archivo stock.lst
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

# Ejecutar consultas AWK especificas
run_awk_queries() {
  echo "================================================================="
  echo "CONSULTAS ESPECIFICAS EN ARCHIVO stock.lst CON AWK"
  echo "================================================================="

  # a) Imprimir solo codigo de productos electronicos
  echo "a) Imprimir solo el codigo de los productos electronicos:"
  echo "   Comando: awk '/electronics/ { print \$1 }' stock.lst"
  awk '/electronics/ { print $1 }' stock.lst
  echo ""

  # b) Productos con precio entre 5000-10000
  echo "b) Productos con precio entre 5000-10000:"
  echo "   Comando: awk '\$3 >= 5000 && \$3 <= 10000' stock.lst"
  awk '$3 >= 5000 && $3 <= 10000' stock.lst
  echo ""

  # c) Todos los productos excepto Jeans
  echo "c) Todos los productos excepto Jeans:"
  echo "   Comando: awk '\$2 != \"Jeans\"' stock.lst"
  awk '$2 != "Jeans"' stock.lst
  echo ""

  # d) Imprimir tercer registro
  echo "d) Tercer registro en el archivo:"
  echo "   Comando: awk 'NR == 3' stock.lst"
  awk 'NR == 3' stock.lst
  echo ""

  # e) Producto con codigo 102
  echo "e) Producto cuyo codigo es 102:"
  echo "   Comando: awk '\$1 == 102' stock.lst"
  awk '$1 == 102' stock.lst
  echo ""

  # f) Productos con nombres que comienzan entre A y D
  echo "f) Productos con nombres que comienzan entre A y D:"
  echo "   Comando: awk '\$2 ~ /^[A-D]/' stock.lst"
  awk '$2 ~ /^[A-D]/' stock.lst
  echo ""

  # g) Productos con nombre de mas de 6 caracteres
  echo "g) Productos con nombre de mas de 6 caracteres:"
  echo "   Comando: awk 'length(\$2) > 6' stock.lst"
  awk 'length($2) > 6' stock.lst
  echo ""

  # h) Productos con cantidad inferior a 10
  echo "h) Productos con cantidad inferior a 10:"
  echo "   Comando: awk '\$4 < 10' stock.lst"
  awk '$4 < 10' stock.lst
  echo ""

  # i) Productos con nombre laptop o Laptop
  echo "i) Productos con nombre laptop o Laptop:"
  echo "   Comando: awk '\$2 ~ /^[Ll]aptop\$/' stock.lst"
  awk '$2 ~ /^[Ll]aptop$/' stock.lst
  echo ""

  # j) Nombre y precio de garments con codigo < 103 y precio > 800
  echo "j) Nombre y precio de garments con codigo < 103 y precio > 800:"
  echo "   Comando: awk '\$5 == \"garments\" && \$1 < 103 && \$3 > 800 { print \$2, \$3 }' stock.lst"
  awk '$5 == "garments" && $1 < 103 && $3 > 800 { print $2, $3 }' stock.lst
  echo ""
}

# Funcion principal
main() {
  check_file
  run_awk_queries
}

# Ejecutar script
main
