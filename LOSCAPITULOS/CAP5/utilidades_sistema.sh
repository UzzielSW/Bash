#!/bin/bash

# Script: utilidades_sistema.sh
# Descripcion: Coleccion de utilidades para obtener informacion del sistema
# Version: 1.2
#
# Este script contiene varias funciones utiles para:
# - Obtener lista de usuarios conectados
# - Contar usuarios conectados
# - Obtener fecha y hora en diferentes formatos
# - Obtener componentes de la hora (horas, minutos, segundos)
# - Obtener hora de entrada del usuario actual
# - Mostrar mensajes personalizados
# - Mostrar informacion del sistema en diferentes formatos
#

# Funcion para obtener lista de usuarios
obtener_usuarios() {
  who | sed 's/ .*$//' | sort -u
}

# Funcion para contar usuarios
contar_usuarios() {
  who | cut -c1-8 | sort -u | wc -l
}

# Funcion para obtener fecha completa
obtener_fecha() {
  date
}

# Funcion para obtener solo el dia
obtener_dia() {
  date | tr -s '\11' ' ' | cut -d' ' -f1 | sed 's/,//'
}

# Funcion para obtener componentes de la hora
obtener_hora_detallada() {
  hora=$(date | cut -d' ' -f4 | cut -d: -f1)
  min=$(date | cut -d' ' -f4 | cut -d: -f2)
  sec=$(date | cut -d' ' -f4 | cut -d: -f3)
  echo "Horas: $hora"
  echo "Minutos: $min"
  echo "Segundos: $sec"
}

# Funcion para obtener hora de entrada del usuario actual
obtener_hora_entrada() {
  horaentrada=$(who am i | tr -s ' ' ' ' | tr -s '\11' ' ' | cut -d' ' -f4 | cut -d: -f1)
  minentrada=$(who am i | tr -s ' ' ' ' | tr -s '\11' ' ' | cut -d' ' -f4 | cut -d: -f2)
  echo "Hora de entrada: $horaentrada"
  echo "Minuto de entrada: $minentrada"
}

# Funcion para mostrar mensaje de bienvenida
mostrar_mensaje() {
  hora=$(date | tr -s '\11' ' ' | cut -d' ' -f4 | cut -d: -f1)
  if [ $hora -ge 5 ] && [ $hora -lt 12 ]; then
    echo "Buenos dias"
  elif [ $hora -ge 12 ] && [ $hora -lt 19 ]; then
    echo "Buenas tardes"
  else
    echo "Buenas noches"
  fi
}

# Funcion para mostrar informacion basica del sistema
mostrar_info_basica() {
  clear
  echo "=== Informacion Basica del Sistema ==="
  echo "Fecha y hora actual:"
  obtener_fecha
  echo
  echo "Numero de usuarios en el sistema:"
  contar_usuarios
  echo
  echo "Directorio actual:"
  pwd
}

# Funcion para mostrar informacion de usuarios
mostrar_info_usuarios() {
  clear
  echo "=== Informacion de Usuarios ==="
  echo "En el sistema hay"
  obtener_fecha
  contar_usuarios
  echo "estudiantes"
  echo
  echo "Sus nombres son:"
  obtener_usuarios | tr '\12' ' '
  echo
}

# Funcion para mostrar informacion completa del sistema
mostrar_info_sistema() {
  clear
  echo "=== Informacion Completa del Sistema ==="
  mostrar_mensaje
  echo
  echo "Fecha actual:"
  obtener_fecha
  echo
  echo "Dia actual:"
  obtener_dia
  echo
  echo "Hora detallada:"
  obtener_hora_detallada
  echo
  echo "Hora de entrada:"
  obtener_hora_entrada
  echo
  echo "Numero de usuarios conectados:"
  contar_usuarios
  echo
  echo "Lista de usuarios conectados:"
  obtener_usuarios
  echo
  echo "Directorio actual:"
  pwd
}

# Menu principal
mostrar_menu() {
  clear
  echo "=== Menu de Utilidades del Sistema ==="
  echo "1. Mostrar informacion basica (fecha, usuarios, directorio)"
  echo "2. Mostrar informacion de usuarios (detallada)"
  echo "3. Mostrar informacion completa"
  echo "4. Salir"
  echo
  read -p "Seleccione una opcion (1-4): " opcion

  case $opcion in
  1) mostrar_info_basica ;;
  2) mostrar_info_usuarios ;;
  3) mostrar_info_sistema ;;
  4) exit 0 ;;
  *) echo "Opcion no valida" ;;
  esac

  echo
  read -p "Presione Enter para continuar..."
  mostrar_menu
}

# Iniciar menu
mostrar_menu
