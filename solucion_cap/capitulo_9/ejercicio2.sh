#!/bin/bash
: '
 monsyst3: Monitorea cuando un usuario entra al sistema e informa el TTY
 Problema: Modificar el programa mon para que tambien imprima el numero de tty
 al que el usuario se conecta. La salida debe mostrar "sandy logged onto tty13"
 si sandy se conecta a tty13.

Cambios y mejoras implementadas:
 1. Solución principal: Modificado para capturar y mostrar el TTY usando awk para extraer la segunda columna de who
 2. Mejora de validación: Reemplazado grep con expresión regular nativa de Bash para validar números
 3. Mejora de seguridad: Uso de getent passwd en lugar de cut en /etc/passwd
 4. Mejora de robustez: Mejor manejo de errores en la función de escritura de mensajes
 5. Optimización: Uso de awk en lugar de múltiples comandos para extraer información del usuario
'

mesgopt=false
interval=5

# Procesa las opciones de linea de comandos
while getopts "wt:" option; do
  case "$option" in
  w) mesgopt=true ;;
  t) interval="$OPTARG" ;;
  \?)
    echo "USO: $0 [-w] [-t n] user"
    echo "  -w  informar por mensaje"
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

# Verifica que se proporciono el nombre de usuario
shift $((OPTIND - 1))
if [[ $# -eq 0 ]]; then
  echo "Error: Debe especificar un nombre de usuario"
  exit 2
fi

user="$1"

# Verifica que el usuario existe en el sistema
if ! getent passwd "$user" >/dev/null 2>&1; then
  echo "Error: $user no es un usuario valido del sistema"
  exit 1
fi

# Monitorea hasta que el usuario se conecte
echo "Monitoreando conexion de $user cada $interval segundos..."
while true; do
  # Busca al usuario en la salida de who y extrae el TTY
  tty_info=$(who | awk -v user="$user" '$1 == user {print $2; exit}')

  if [[ -n "$tty_info" ]]; then
    # Usuario encontrado - extrae el numero de TTY
    if [[ "$mesgopt" == false ]]; then
      echo "$user logged onto $tty_info"
    else
      # Envia mensaje al usuario actual
      current_user=$(whoami)
      current_tty=$(tty | sed 's|/dev/||')
      echo "$user logged onto $tty_info $(date)" | write "$current_user" "$current_tty" 2>/dev/null ||
        echo "$user logged onto $tty_info $(date)" | mail "$current_user" 2>/dev/null ||
        echo "$user logged onto $tty_info"
    fi
    break
  fi

  sleep "$interval"
done
