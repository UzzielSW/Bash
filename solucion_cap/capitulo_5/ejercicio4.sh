#!/bin/bash
: '
PROBLEMA:
Escribe un programa llamado whos para mostrar una lista ordenada de los usuarios conectados. Solo muestra los
nombres de usuario y ninguna otra informacion.
'

# Obtener usuarios activos, extraer solo nombres y ordenar
who | awk '{print $1}' | sort
