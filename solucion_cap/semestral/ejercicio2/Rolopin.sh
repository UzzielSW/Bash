#!/bin/bash
: '
 Rolopin sin funciones
'

# Exporta la variable para que otros programas la utilicen
: ${PHONEBOOK:=./phonebook}
export PHONEBOOK

if [ ! -e "$PHONEBOOK" ]; then
  echo " $PHONEBOOK no existe! "
  echo -n "Should I Create it for you(y/n)? "
  read answer
  if [ "$answer" != yes ]; then
    exit 1
  fi
  >$PHONEBOOK || exit 1 #sale si la creacion falla
fi

# Si se suministran argumentos, realiza la busqueda

if [ "$#" -ne 0 ]; then
  lub "$@"
  exit
fi

# Captura la interrupcion (Ctrl+C) para continuar con el bucle
trap "continue" 2

validchoice="" # Inicializa la variable en vacio

while true; do
  clear
  echo -n "
      Ud desea:

               1. Buscar
               2. Agregar
               3. Remover
               4. Modificar
               5. Listar
               6. Salir
      Seleccione (1-6):   "
  read choice
  echo

  case "$choice" in
  1)
    echo -n "Entre el nombre:  "
    read nombre
    if [ -z "$nombre" ]; then
      echo "la busqueda ha sido ignorada "
    else

      lub "$nombre"
    fi
    echo -n "Enter para continuar: "
    read resp
    ;;
  2)
    add
    echo -n "Enter para continuar: "
    read resp
    ;;

  3)
    echo -n "Entre el nombre que se debe remover: "
    read nombre
    if [ -z "$nombre" ]; then
      echo -n "La remocion ha sido ignorada "
    else
      remb "$nombre"
      echo "$nombre ha sido removido de phonebook"
      echo
    fi
    echo -n "Enter para continuar: "
    read resp
    ;;
  4)
    echo -n "Ingrese el nombre que desea cambiar: "
    read nombre
    if [ -z "$nombre" ]; then
      echo -n "La modificacion ha sido ignorada "
    else
      change "$nombre"
    fi
    echo -n "Enter para continuar: "
    read resp
    ;;
  5)
    listall
    echo -n "Enter para continuar: "
    read resp
    ;;
  6)
    echo "Adios ... "
    sleep 2
    exit 0
    ;;

  *)
    echo "Opcion Invalida"
    echo -n "Enter para continuar"
    read resp
    ;;
  esac
done
