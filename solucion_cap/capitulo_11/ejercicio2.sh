#!/bin/bash

# Analisis del comportamiento de variables de entorno en Bash
# Problema: Determinar la salida de prog2 cuando se ejecuta desde prog1
# con diferentes configuraciones de variables de entorno
#
# Contexto:
# - prog1 define e1=100 y la exporta, define e2=200 (sin exportar)
# - prog1 ejecuta prog2 con e3=300 como variable de entorno local
# - prog2 imprime las variables e1, e2, e3, e4
# - Antes de ejecutar prog1, se define e2=20 y se exporta, e4=40 como variable local

# Simulacion del contenido de prog1
function prog1() {
  # Variable exportada desde prog1
  e1=100
  export e1

  # Variable local en prog1 (no exportada)
  e2=200

  # Ejecutar prog2 con e3=300 como variable de entorno
  e3=300 prog2
}

# Simulacion del contenido de prog2
function prog2() {
  # prog2 imprime las 4 variables
  echo $e1 $e2 $e3 $e4
}

# Simulacion de la ejecucion completa
echo "# Simulacion del comportamiento de variables de entorno"
echo "# Configuracion inicial:"
echo "# e2=20; export e2"
echo "# e4=40 prog1"
echo

# Establecer e2 como variable exportada (disponible para subprocesos)
e2=20
export e2

echo "Salida esperada:"
e4=40 prog1
