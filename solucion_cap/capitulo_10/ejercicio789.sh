#!/bin/bash
: '
 7: Modifica el programa rem utilizado por rolo de manera que, si se encuentran multiples entradas, el programa
 solicite al usuario la entrada a eliminar. Ejemplo de sesion:
 $ rolo
    ...
       Por favor seleccione una de las anteriores (1-3): 3
 Ingrese el nombre a eliminar: Susan
 Se encontraron varias coincidencias; seleccione la que desea eliminar:
 Susan Goldberg    Eliminar (y/n)? n
 Susan Topple      Eliminar (y/n)? y
 $

 8: Modifica rolo de modo que el menu se vuelva a mostrar despues de cada seleccion procesada. Para permitir que el usuario salga, agrega otra opcion al menu para terminar el programa.
 9: ¿Qué ocurre con el programa rolo si sólo se da un Enter como nombre para las opciones de añadir, buscar o eliminar?

Solucion:
Si se ingresa solo Enter, el programa detecta que $nombre está vacío con [ -z "$nombre" ] y muestra el mensaje "la busqueda ha sido ignorada" sin ejecutar la función lub.


'

# Exporta la variable para que otros programas la utilicen
: ${PHONEBOOK:=./phonebook}
export PHONEBOOK

# Funcion: remb
# Elimina una entrada del directorio telefonico
# Uso: remb "Nombre a eliminar"
remb() {
  local nombre="$1"
  local tmp_dir="temp"
  local tmp_matches="$tmp_dir/matches$$"
  local tmp_phonebook="$tmp_dir/phonebook$$"

  # Crear directorio temporal si no existe
  mkdir -p "$tmp_dir"

  # Buscar coincidencias y almacenarlas
  grep "$nombre" "$PHONEBOOK" >"$tmp_matches"

  # Verificar si se encontro al menos una coincidencia
  if [ ! -s "$tmp_matches" ]; then
    echo "No se encontro a $nombre en la libreta de telefonos."
    rm -f "$tmp_matches"
    return 1
  fi

  local linea respuesta
  # Mostrar cada coincidencia y confirmar la eliminacion
  while read -r linea; do
    display "$linea"
    echo -n "¿Eliminar esta entrada (y/n)? "
    read respuesta </dev/tty
    if [ "$respuesta" = "y" ]; then
      break
    fi
  done <"$tmp_matches"

  rm -f "$tmp_matches"

  # Si el usuario confirmo la eliminacion, actualizar la libreta
  if [ "$respuesta" = "y" ]; then
    if grep -v "^$linea$" "$PHONEBOOK" >"$tmp_phonebook"; then
      mv "$tmp_phonebook" "$PHONEBOOK"
      echo "La entrada seleccionada ha sido eliminada."
    else
      echo "No se pudo procesar la eliminacion."
    fi
  fi
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

  #
  # Display matching entries one at a time and confirm change
  #

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
