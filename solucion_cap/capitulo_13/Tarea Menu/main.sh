#!/bin/bash

valida_cell() {
  # Verifica si se proporciono un argumento
  if [ $# -ne 1 ]; then
    # Solicita al usuario que ingrese un numero de celular
    read -p "Ingrese un numero de celular para validar: " number_input

    if [[ "$number_input" =~ ^\+507\ [6][0-9]{3}-[0-9]{4}$ ]]; then
      echo -e "$number_input - [\e[32mOK\e[0m] Numero valido"
    else
      echo -e "$number_input - [\e[31mX\e[0m] Numero no valido"
    fi
  fi
}

valida_ip() {
  if [ $# -ne 1 ]; then
    # Solicita al usuario que ingrese una direccion IP
    read -p "Ingrese una direccion IP para validar: " ip_input

    if [[ $ip_input =~ ^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$ ]]; then
      echo -e "$ip_input - [\e[32mOK\e[0m] IP valida"
    else
      echo -e "$ip_input - [\e[31mX\e[0m] IP no valida"
    fi
  fi
}

valida_mac() {
  # Verifica si se proporciono un argumento
  if [ $# -ne 1 ]; then
    # Solicita al usuario que ingrese una direccion MAC
    read -p "Ingrese una direccion MAC para validar: " mac_input

    if [[ $mac_input =~ ^([0-9A-Fa-f]{2}[:-]){5}([0-9A-Fa-f]{2})$ ]]; then
      echo -e "$mac_input - [\e[32mOK\e[0m] MAC valida"
    else
      echo -e "$mac_input - [\e[31mX\e[0m] MAC no valida"
    fi
  fi
}

while true; do
  clear
  echo -n "
      Ud desea:
        1. Validar IP
        2. Validar numero de celular (Panamá)
        3. Validar MAC
        4. Salir
    Seleccione (1-4):   "
  read choice
  echo

  case "$choice" in
  1)
    valida_ip
    read pause
    ;;

  2)
    valida_cell
    read pause
    ;;

  3)
    valida_mac
    read pause
    ;;

  4)
    echo "Adios..."
    exit 0
    ;;

  *) echo "Opcion Invalida" ;;

  esac
done
