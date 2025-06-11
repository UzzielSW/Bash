#!/bin/bash
: '
 Programa conntime: Calcula las horas y minutos que un usuario
 ha estado conectado al sistema (asumiendo menos de 24 horas)
 Utiliza los comandos date y who para obtener la informacion
'

# Verificar que se proporcione un nombre de usuario
if [[ $# -ne 1 ]]; then
    echo "Uso: $0 <nombre_usuario>"
    exit 1
fi

usuario="$1"

# Obtener informacion del usuario conectado usando who
info_usuario=$(who | grep "^$usuario ")

# Verificar si el usuario esta conectado
if [[ -z "$info_usuario" ]]; then
    echo "Usuario '$usuario' no esta conectado actualmente"
    exit 1
fi

# Extraer la fecha y hora de conexion del usuario
# Formato tipico de who: usuario tty fecha hora
fecha_conexion=$(echo "$info_usuario" | awk '{print $3, $4}')

# Obtener timestamp actual en segundos
timestamp_actual=$(date +%s)

# Convertir fecha de conexion a timestamp
timestamp_conexion=$(date -d "$fecha_conexion" +%s 2>/dev/null)

# Manejar error en conversion de fecha
if [[ $? -ne 0 ]]; then
    echo "Error: No se pudo procesar la fecha de conexion"
    exit 1
fi

# Calcular diferencia en segundos
diferencia_segundos=$((timestamp_actual - timestamp_conexion))

# Convertir a horas y minutos
horas=$((diferencia_segundos / 3600))
minutos=$(((diferencia_segundos % 3600) / 60))

# Mostrar resultado
echo "Usuario '$usuario' ha estado conectado: ${horas} horas y ${minutos} minutos"
