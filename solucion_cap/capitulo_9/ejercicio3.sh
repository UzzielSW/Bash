#!/bin/bash
: '
 monsyst3: Monitorea cuando un usuario entra al sistema o cuando existe un archivo

 Problema: Agregar una opcion -f a monsys3 para verificar periodicamente la existencia
 de un archivo (archivo ordinario o directorio) en lugar de verificar que un usuario
 se conecte. Escribir "mon -f /usr/spool/uucppublic/steve/newmemo &" debe hacer que
 mon verifique periodicamente la existencia del archivo indicado e informe cuando
 lo haga (mostrando un mensaje o por correo si tambien se selecciona la opcion -m).
'

mesgopt=false
fileopt=false
interval=5
target=""

# Procesa las opciones de linea de comandos
while getopts "wf:t:" option; do
  case "$option" in
  w) mesgopt=true ;;
  f)
    fileopt=true
    target="$OPTARG"
    ;;
  t) interval="$OPTARG" ;;
  \?)
    echo "USO: $0 [-w] [-f archivo] [-t n] [usuario]"
    echo "  -w  informar por mensaje"
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
  echo "Monitoreando archivo $target cada $interval segundos..."
  while true; do
    if [[ -e "$target" ]]; then
      send_notification "File $target now exists"
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
