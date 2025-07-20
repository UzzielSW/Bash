#! /bin/bash
# rolo - programa que busca, agrega, y remueve personas de un directorio telefonico
#
# Si se suministra argumento entonces busca and export it so other progs know about it

# DIRECT=$HOME/CAP11/phonebook
DIRECT=./phonebook
PHONEBOOK=$DIRECT
export PHONEBOOK

if [ ! -f "$PHONEBOOK" ]; then
  echo "No phonebook file in $DIRECT ! "
  exit 1
fi

#
# If the arguments are suplied, the do lookup
#

if [ "$#" -ne 0 ]; then
  lub "$@"
  exit
fi

validchoice="" #set it null

#
#  Bucle hasta que una sleccion valida se escoja
#

until [ -n "$validchoice" ]; do
  #
  # Despliega el Menu
  #

  #
  # Despliega el menu
  #
  #
  clear
  echo -n " 
      Ud desea:

               1. Buscar 
               2. Agregar 
               3. Remover
               4. Salir
      Seleccione (1-4):   "

  #
  #
  # Lee y procesa la seleccion
  #

  read choice
  echo

  case "$choice" in
  1)
    echo -n "Entre el nombre:  "
    read nombre
    lub "$nombre"
    echo -n "Enter para continuar: "
    read resp
    ;;

  2)
    echo -n "Entre el nombre que debe ser agregado: "
    read nombre
    echo -n "entre el numero de telefono: "
    read numero
    add2 "$nombre" "$numero"
    echo "$nombre   $numero se ha agregado a phonebook"
    echo -n "Enter para continuar: "
    read resp
    ;;

  3)
    echo -n "Entre el nombre que se debe remover: "
    read nombre
    remb "$nombre"
    echo "$nombre ha sido removido de phonebook"
    echo -n "Enter para continuar: "
    read resp
    ;;

  4)
    echo "Adios ... "
    sleep 2
    clear
    validchoice=TRUE
    ;;

  *)
    echo "Opcion Invalida"
    echo -n "Enter para continuar"
    read resp
    ;;
  esac
done
