#!/bin/bash

: '
 Programa home reescrito usando el comando set e IFS para extraer el directorio
 de inicio desde /etc/passwd. Analiza el comportamiento cuando algun campo es nulo.

 El programa toma el nombre de un usuario como argumento e imprime su directorio
 de inicio. Usa set e IFS para dividir los campos del archivo /etc/passwd.

 Ejemplo de entrada con campo nulo:
 steve:*:203:100::/users/steve:/usr/bin/ksh
 Aqui el quinto campo (comentario) esta vacio (::)
'

# Verificar si se proporciono un argumento
if [ $# -ne 1 ]; then
  echo "Uso: $0 <nombre_usuario>"
  echo 1
fi

usuario="$1"

# Buscar la linea del usuario en /etc/passwd
linea_usuario=$(grep "^${usuario}:" /etc/passwd)

# Verificar si se encontro el usuario
if [ -z "$linea_usuario" ]; then
  echo "Usuario no encontrado"
  echo 1
fi

# Guardar el IFS actual para restaurarlo despues
IFS_original="$IFS"

# Establecer IFS a dos puntos para dividir los campos
IFS=':'

# Usar set para dividir la linea en campos posicionales
# Esto asigna cada campo separado por ':' a $1, $2, $3, etc.
set -- $linea_usuario

# Restaurar el IFS original
IFS="$IFS_original"

# El directorio de inicio esta en el campo 6 (sexto parametro posicional)
directorio_inicio="$6"

# Verificar si el directorio de inicio esta vacio
if [ -z "$directorio_inicio" ]; then
  echo "Directorio de inicio no especificado para el usuario $usuario"
  exit 1
fi

# Imprimir el directorio de inicio
echo "$directorio_inicio"

# Nota: Cuando hay campos nulos (como ::), el comando set los trata como
# parametros vacios. Esto significa que $5 estara vacio pero $6 seguira
# conteniendo el valor correcto del directorio de inicio.
