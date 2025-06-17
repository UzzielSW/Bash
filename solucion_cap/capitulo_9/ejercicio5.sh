#!/bin/bash
: '
 collect: Programa que se ejecuta en segundo plano y cuenta el numero de usuarios
 conectados al final de cada intervalo y tambien el numero de procesos ejecutados
 durante ese intervalo. Permite especificar el intervalo con la opcion -t, con
 un valor por defecto de 10 minutos. Usa el hecho de que la variable especial $!
 se establece al numero de proceso del ultimo comando ejecutado en segundo plano
 y que ": &" ejecuta un comando nulo en segundo plano. Debe manejar correctamente
 el caso donde el numero de proceso vuelve a 1 despues de alcanzar el maximo.
'

interval=600 # 10 minutos por defecto (en segundos)

# Procesa las opciones de linea de comandos
while getopts "t:" option; do
  case "$option" in
  t) interval="$OPTARG" ;;
  \?)
    echo "USO: $0 [-t segundos]"
    echo "  -t  intervalo en segundos (defecto: 600)"
    exit 1
    ;;
  esac
done

# Valida que el intervalo sea un numero valido
if [[ ! "$interval" =~ ^[0-9]+$ ]] || [[ "$interval" -eq 0 ]]; then
  echo "Error: El intervalo debe ser un numero entero positivo" >&2
  exit 1
fi

# Obtiene el PID inicial ejecutando comando nulo en background
: &
start_pid=$!

# Variables para el seguimiento de procesos
last_max_pid=$start_pid
processes_count=0

# Funcion para contar procesos en el intervalo
count_processes() {
  local current_max_pid
  local new_processes=0

  # Ejecuta comando nulo para obtener PID actual mas alto disponible
  : &
  current_max_pid=$!

  # Calcula procesos creados considerando el wraparound
  if [[ $current_max_pid -ge $last_max_pid ]]; then
    # Caso normal: no hubo wraparound
    new_processes=$((current_max_pid - last_max_pid))
  else
    # Caso wraparound: el PID volvio a empezar desde 1
    # Asume PID maximo del sistema (generalmente 32768 o 4194304)
    local max_system_pid
    max_system_pid=$(cat /proc/sys/kernel/pid_max 2>/dev/null || echo 32768)
    new_processes=$((max_system_pid - last_max_pid + current_max_pid))
  fi

  last_max_pid=$current_max_pid
  echo $new_processes
}

# Configuracion de senales para terminacion limpia
trap 'exit 0' TERM INT

# Bucle principal de recoleccion
while true; do
  # Cuenta usuarios conectados
  user_count=$(who | wc -l)

  # Cuenta procesos ejecutados durante el intervalo
  process_count=$(count_processes)

  # Imprime estadisticas con timestamp
  printf "%s: Users=%d Processes=%d\n" "$(date '+%Y-%m-%d %H:%M:%S')" "$user_count" "$process_count"

  # Espera el intervalo especificado
  sleep "$interval"
done
