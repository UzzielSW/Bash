#! /bin/bash
# rolo - programa que busca, agrega y remueve personas de un directorio telefonico
# Si se suministra argumento entonces busca y lo exporta para que otros programas lo sepan

lub() {
  if [ "$#" -ne 1 ]; then
    echo "Numero incorrecto de argumentos"
    echo "Uso: lub nombre"
    exit 1
  fi

  nombre=$1
  grep "$nombre" $PHONEBOOK

  if [ $? -ne 0 ]; then
    echo "No pude encontrar $nombre en el directorio"
  fi
}

add2() {
  if [ "$#" -ne 2 ]; then
    echo "Numero incorrecto de argumentos"
    echo "Uso: add2 nombre numero"
    exit
  fi

  echo -e "\n$1\t$2" >>$PHONEBOOK
  sort -o $PHONEBOOK $PHONEBOOK
}

remb() {
  # Remueve a alguien del directorio

  if [ "$#" -ne 1 ]; then
    echo "Numero incorrecto de argumentos"
    echo "Uso: remb nombre"
    exit 1
  fi

  nombre=$1

  # Encuentra el numero de coincidencias
  coincidencias=$(grep "$nombre" $PHONEBOOK | wc -l)

  # Si hay mas de una coincidencia, muestra mensaje, si no, lo elimina
  if [ "$coincidencias" -gt 1 ]; then
    echo "Mas de una coincidencia; por favor sea mas especifico"
  elif [ "$coincidencias" -eq 1 ]; then
    grep -v "$nombre" $PHONEBOOK >/tmp/phonebook$$
    mv /tmp/phonebook$$ $PHONEBOOK
  else
    echo "No pude encontrar $nombre en el directorio"
  fi
}

# DIRECTORIO DEL PHONEBOOK
${DIRECT:=./phonebook}
PHONEBOOK=$DIRECT
export PHONEBOOK

if [ ! -f "$PHONEBOOK" ]; then
  echo "No existe el archivo phonebook en $DIRECT!"
  exit 1
fi

# Si se suministran argumentos, realiza la busqueda
if [ "$#" -ne 0 ]; then
  lub "$@"
  exit
fi

validchoice="" # Inicializa como vacio

until [ -n "$validchoice" ]; do
  # Despliega el Menu

  clear
  echo -n " 
      Que desea hacer?:

               1. Buscar 
               2. Agregar 
               3. Remover
               4. Salir
      Seleccione (1-4):   "

  # Lee y procesa la seleccion
  read choice
  echo

  case "$choice" in
  1)
    read -p "Ingrese el nombre: " nombre
    lub "$nombre"
    ;;

  2)
    read -p "Ingrese el nombre que desea agregar: " nombre
    read -p "Ingrese el numero de telefono: " numero
    add2 "$nombre" "$numero"
    echo "$nombre   $numero se ha agregado a phonebook"
    ;;
  3)
    read -p "Ingrese el nombre que desea remover: " nombre
    remb "$nombre"
    echo "$nombre ha sido removido de phonebook"
    ;;
  4)
    exit 0
    ;;
  *)
    echo "Opcion invalida"
    ;;
  esac

  echo
  read -p ".:Presione Enter para continuar:."
done
