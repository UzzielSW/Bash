#!/bin/bash

# Escribe un programa llamado home que toma el nombre de un usuario como su unico argumento
# e imprime el directorio de inicio de ese usuario.

# Verificar si se proporciono un argumento
if [ $# -ne 1 ]; then
    echo "Uso: $0 <nombre_usuario>"
    exit 1
fi

# Nota: El comando getent passwd se utiliza para obtener la informacion del usuario desde la base de datos de passwd,
# que puede incluir fuentes como /etc/passwd y LDAP. El comando cut se utiliza para extraer el sexto campo,
# que corresponde al directorio de inicio del usuario

# Buscar el directorio de inicio del usuario en /etc/passwd
directorio_inicio=$(getent passwd "$1" | cut -d: -f6) # valida exactamente el nombre del usuario
# directorio_inicio=$(grep "$1" /etc/passwd | cut -d':' -f6) # sin validacion exacta

# Verificar si se encontro el usuario
if [ -z "$directorio_inicio" ]; then
    echo "Usuario no encontrado"
    exit 1
fi

# Imprimir el directorio de inicio
echo "$directorio_inicio"
