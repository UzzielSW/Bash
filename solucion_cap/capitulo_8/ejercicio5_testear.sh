#!/bin/bash
: '
Usa los comandos date y who para escribir un programa llamado conntime que imprima el número de
horas y minutos que un usuario ha estado conectado al sistema (supongamos que es menos de 24 horas).
24 horas).

# conntime - Script para calcular cuánto tiempo ha estado conectado un usuario
# Uso: ./conntime
'

# Obtener todos los usuarios que están actualmente conectados
who_output=$(who)

# Obtener la hora actual
current_date=$(date "+%H:%M")
current_hour=$(echo $current_date | cut -d: -f1)
current_minute=$(echo $current_date | cut -d: -f2)

# Convertir la hora actual a minutos desde medianoche
current_time_minutes=$((current_hour * 60 + current_minute))

# Procesar cada sesión de usuario
echo "$who_output" | while read -r line; do
  # Extraer nombre de usuario y hora de inicio de sesión
  username=$(echo "$line" | awk '{print $1}')
  terminal=$(echo "$line" | awk '{print $2}')
  login_date=$(echo "$line" | awk '{print $3}')
  login_time=$(echo "$line" | awk '{print $4}')

  # Extraer horas y minutos de la hora de inicio de sesión
  login_hour=$(echo "$login_time" | cut -d: -f1)
  login_minute=$(echo "$login_time" | cut -d: -f2)

  # Convertir la hora de inicio de sesión a minutos desde medianoche
  login_time_minutes=$((login_hour * 60 + login_minute))

  # Calcular la diferencia en minutos
  diff_minutes=$((current_time_minutes - login_time_minutes))

  # Asegurarse de que no obtenemos valores negativos (asumiendo < 24 horas)
  if [ $diff_minutes -lt 0 ]; then
    # Si cruzamos la medianoche, sumar 24 horas en minutos
    diff_minutes=$((diff_minutes + 24 * 60))
  fi

  # Convertir de nuevo a horas y minutos
  hours=$((diff_minutes / 60))
  minutes=$((diff_minutes % 60))

  echo "User $username on $terminal has been connected for $hours hours and $minutes minutes"
done

exit 0
