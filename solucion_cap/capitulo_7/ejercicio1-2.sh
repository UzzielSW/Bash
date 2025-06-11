#!/bin/bash
: '
 Buscar a alguien en la guía telefónica
 1: Modificado para ignorar mayúsculas y minúsculas durante la búsqueda
'

# Usar grep con flag -i para búsqueda insensible a mayúsculas/minúsculas
grep -i "$1" phonebook

: '
 2: ¿Qué ocurre si olvidas proporcionar un argumento al programa lu?
    ¿Qué ocurre si el argumento argumento es nulo (por ejemplo, lu "")?

 1. Si olvidas proporcionar un argumento al programa lu:
 - `$1` será una cadena vacía (null/empty string)
 - `grep ""` buscará una cadena vacía, lo que coincidirá con todas las líneas del archivo phonebook
 
 2. Si el argumento es null (como en `lu ""`):
 - Es exactamente el mismo comportamiento que el caso anterior
'
