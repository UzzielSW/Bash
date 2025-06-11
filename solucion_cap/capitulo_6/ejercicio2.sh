#!/bin/bash

: '
 Eliminar todos los caracteres de espacio almacenados en la variable 
 de shell 'text'. Asegurar que el resultado se asigne de vuelta a 'text'.
 Primero usar tr para hacerlo y luego hacer lo mismo con sed.
'

text="Hola mundo con espacios"

# Método 1: Usando tr para eliminar espacios
# tr -d ' ' elimina todos los caracteres de espacio
text=$(echo "$text" | tr -d ' ')
echo "Resultado con tr: $text"

text="Hola mundo con espacios"

# Método 2: Usando sed para eliminar espacios
# 's/ //g' sustituye todos los espacios por nada (los elimina)
text=$(echo "$text" | sed 's/ //g')
echo "Resultado con sed: $text"

# Alternativas más robustas que manejan múltiples tipos de espacios en blanco:

# Con tr (elimina espacios, tabs, newlines)
# text=$(echo "$text" | tr -d '[:space:]')

# Con sed (elimina solo espacios normales)
# text=$(sed 's/[[:space:]]//g' <<< "$text")
