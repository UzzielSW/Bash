#!/bin/bash
: '
 Rolopin.sh con funciones para agregar, buscar, eliminar, modificar y listar.
'

# Exporta la variable para que otros programas la utilicen
: ${PHONEBOOK:=./phonebook}
export PHONEBOOK

# Elimina una entrada del directorio telefonico
remb() {
  grep "$1" phonebook >salida
  numero=$(cat salida | wc -l | tr -s ' ' ' ')
  if [ "$numero" -gt 1 ]; then
    echo "Hay mas de un emparejamiento "
    exec <salida
    while read line; do
      echo "$line remover (yes/no): "
      exec </dev/tty
      read resp
      echo "$resp"
      if [ "$resp" = yes ]; then
        grep -v "$line" phonebook >tmp/phonebook
        mv tmp/phonebook phonebook
      fi
      grep -v "$line" salida >tmp/salida
      mv tmp/salida salida
      exec <salida
    done
  else
    grep -v "$1" phonebook >tmp/phonebook
    mv tmp/phonebook phonebook
  fi
  rm salida

}

lub() {
  # Look someone up in the phone book

  if [ "$#" -ne 1 ]; then
    echo "Incorrect number of arguments"
    echo "Usage: lub name"
    exit 1
  fi

  name=$1
  grep "$name" $PHONEBOOK

  if [ $? -ne 0 ]; then
    echo "I couldn't find $name in the phonebok"
  fi
}

add() {

  first=
  entry=

  while true; do

    echo -n ">> "
    read line

    if [ -n "$line" ]; then
      entry="$entry$line^"
      if [ -z "$first" ]; then
        first=$line
      fi
    else
      break
    fi
  done

  echo "$entry" >>$PHONEBOOK
  sort -o $PHONEBOOK $PHONEBOOK
  echo
  echo "$first ha sido  agregado a phonebook "
}

display() {
  echo
  echo "------------------------------"

  entry=$1
  IFS="^"
  set entry

  for line in "$1" "$2" "$3" "$4" "$5" "$6"; do
    printf "| %-34.34s |\n" $line
  done

  echo "|         o            o      |"
  echo "-------------------------------"
  echo
}

change() {
  name=$1

  grep "$name" $PHONEBOOK >/tmp/matches$$

  if [ ! -s /tmp/matches$$ ]; then
    echo -n "I can't find $name in the phone boo"
    exit 1
  fi

  while true; do
    display "$line"
    echo -n "Change this entry (y/n)?:  "
    read answer </dev/tty
    if [ "$answer" = y ]; then
      break
    fi

  done </tmp/matches$$

  rm /tmp/matches$$

  if [ "$answer" = y ]; then
    exit
  fi

  #
  # Start up editor on the confirmed entry
  #
  echo -n "$line" | tr
}

listall() {
  sort $PHONEBOOK
}

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
