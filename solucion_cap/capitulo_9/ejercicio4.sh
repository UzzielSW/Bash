#!/bin/bash
: '
# monsyst3: Monitorea cuando un usuario entra/sale del sistema o cuando existe/desaparece un archivo
# Problema: Agregar una opcion -n a mon que invierte la funcion de monitoreo.
# "monsyst3 -n sandy" verifica que sandy se desconecte del sistema, y
# "monsyst3 -n -f /tmp/dataout &" verifica periodicamente la eliminacion del archivo especificado.
'

mesgopt=false
fileopt=false
negateopt=false
interval=5
target=""

# Procesa las opciones de linea de comandos
while getopts "wnf:t:" option; do
  case "$option" in
  w) mesgopt=true ;;
  n) negateopt=true ;;
  f)
    fileopt=true
    target="$OPTARG"
    ;;
  t) interval="$OPTARG" ;;
  \?)
    echo "USO: $0 [-w] [-n] [-f archivo] [-t n] [usuario]"
    echo "  -w  informar por mensaje"
    echo "  -n  invertir monitoreo (desconexion/eliminacion)"
    echo "  -f  monitorear archivo en lugar de usuario"
    echo "  -t  verificar cada n segundos"
    exit 1
    ;;
  esac
done

# Valida que el intervalo sea un numero valido
if [[ ! "$interval" =~ ^[0-9]+$ ]]; then
  echo "Error: El intervalo debe ser un numero entero positivo"
  exit 1
fi

# Verifica argumentos segun el modo seleccionado
shift $((OPTIND - 1))

if [[ "$fileopt" == true ]]; then
  # Modo archivo: el target ya fue establecido por -f
  if [[ -z "$target" ]]; then
    echo "Error: Debe especificar un archivo con -f"
    exit 2
  fi

  # Para modo negativo con archivo, verifica que exista inicialmente
  if [[ "$negateopt" == true && ! -e "$target" ]]; then
    echo "Error: El archivo $target no existe para monitorear su eliminacion"
    exit 3
  fi
else
  # Modo usuario: necesita el nombre de usuario como argumento
  if [[ $# -eq 0 ]]; then
    echo "Error: Debe especificar un nombre de usuario"
    exit 2
  fi
  target="$1"

  # Verifica que el usuario existe en el sistema
  if ! getent passwd "$target" >/dev/null 2>&1; then
    echo "Error: $target no es un usuario valido del sistema"
    exit 1
  fi

  # Para modo negativo con usuario, verifica que este conectado inicialmente
  if [[ "$negateopt" == true ]]; then
    if ! who | awk -v user="$target" '$1 == user {exit 0} END {exit 1}'; then
      echo "Error: El usuario $target no esta conectado para monitorear su desconexion"
      exit 3
    fi
  fi
fi

# Funcion para enviar notificacion
send_notification() {
  local message="$1"

  if [[ "$mesgopt" == false ]]; then
    echo "$message"
  else
    current_user=$(whoami)
    current_tty=$(tty 2>/dev/null | sed 's|/dev/||')

    if [[ -n "$current_tty" ]]; then
      echo "$message $(date)" | write "$current_user" "$current_tty" 2>/dev/null ||
        echo "$message $(date)" | mail "$current_user" 2>/dev/null ||
        echo "$message"
    else
      echo "$message $(date)" | mail "$current_user" 2>/dev/null ||
        echo "$message"
    fi
  fi
}

# Monitoreo principal
if [[ "$fileopt" == true ]]; then
  if [[ "$negateopt" == true ]]; then
    echo "Monitoreando eliminacion del archivo $target cada $interval segundos..."
    while true; do
      if [[ ! -e "$target" ]]; then
        send_notification "File $target has been removed"
        break
      fi
      sleep "$interval"
    done
  else
    echo "Monitoreando archivo $target cada $interval segundos..."
    while true; do
      if [[ -e "$target" ]]; then
        send_notification "File $target now exists"
        break
      fi
      sleep "$interval"
    done
  fi
else
  if [[ "$negateopt" == true ]]; then
    echo "Monitoreando desconexion de $target cada $interval segundos..."
    while true; do
      if ! who | awk -v user="$target" '$1 == user {exit 0} END {exit 1}'; then
        send_notification "$target logged off the system"
        break
      fi
      sleep "$interval"
    done
  else
    echo "Monitoreando conexion de $target cada $interval segundos..."
    while true; do
      tty_info=$(who | awk -v user="$target" '$1 == user {print $2; exit}')

      if [[ -n "$tty_info" ]]; then
        send_notification "$target logged onto $tty_info"
        break
      fi
      sleep "$interval"
    done
  fi
fi
