#!/bin/bash
: '
 PROBLEMA:
 Escribe los comandos para:
 a. Encontrar todos los usuarios conectados con nombres de usuario de al menos cuatro caracteres.
 b. Encontrar todos los usuarios en el sistema cuyos IDs de usuario sean mayores que 99.
 c. Encontrar el numero de usuarios en el sistema cuyos IDs de usuario sean mayores que 99.
 d. Listar todos los archivos en tu directorio en orden decreciente de tamaño.
'

# a. Usuarios conectados con nombres de al menos 4 caracteres
echo "a. Usuarios conectados con nombres >= 4 caracteres:"
who | awk '{print $1}' | grep -E '^.{4,}$' | sort -u

# b. Usuarios del sistema con ID > 99
echo -e "\nb. Usuarios con ID > 99:"
awk -F: '$3 > 99 {print $1 " (ID:" $3 ")"}' /etc/passwd | sort

# c. Numero de usuarios con ID > 99
echo -e "\nc. Numero de usuarios con ID > 99:"
awk -F: '$3 > 99 {count++} END {print count}' /etc/passwd

# d. Archivos ordenados por tamano (decreciente)
echo -e "\nd. Archivos ordenados por tamano decreciente:"
ls -l | awk 'NR>1 && !/^total/ {print $5, $9}' | sort -nr
