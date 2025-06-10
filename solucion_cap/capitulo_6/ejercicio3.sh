#!/bin/bash

: '
 PROBLEMA:
 Escribir comandos para contar el número de caracteres almacenados en la 
 variable shell 'text'. Luego escribir comandos para contar todos los 
 caracteres alfabéticos. (Pista: Usar sed y wc.) ¿Qué sucede con las 
 secuencias de caracteres especiales como \n si están almacenadas dentro 
 de text?
'

# Variable de ejemplo con contenido mixto incluyendo secuencias especiales
text="Hola mundo\nEsto es una prueba123\t¡Con símbolos!"

# 1. Contar el número total de caracteres en la variable
echo "Contenido de la variable text:"
echo -e "$text"
echo

echo "Total de caracteres (incluyendo secuencias especiales):"
echo -n "$text" | wc -c

echo "Total de caracteres (interpretando secuencias especiales):"
echo -e "$text" | wc -c

# 2. Contar solo caracteres alfabéticos usando sed y wc
echo "Caracteres alfabéticos solamente:"
echo -n "$text" | sed 's/[^a-zA-ZáéíóúÁÉÍÓÚñÑ]//g' | wc -c

# Demostración del comportamiento de secuencias especiales
echo
echo "=== ANÁLISIS DE SECUENCIAS ESPECIALES ==="
echo "Variable original (sin interpretación):"
echo "$text" | od -c

echo
echo "Variable con interpretación de secuencias especiales:"
echo -e "$text" | od -c

# Ejemplo adicional mostrando diferencias
text_with_newlines="Línea1\nLínea2\nLínea3"
echo
echo "Ejemplo con múltiples \\n:"
echo "Sin interpretar: $(echo -n "$text_with_newlines" | wc -c) caracteres"
echo "Interpretado: $(echo -e "$text_with_newlines" | wc -c) caracteres"
echo "Solo alfabéticos: $(echo -n "$text_with_newlines" | sed 's/[^a-zA-Z]//g' | wc -c) caracteres"