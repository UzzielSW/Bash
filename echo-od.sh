#!/bin/bash

# EXPLICACIÓN DE COMANDOS echo y od

# ECHO -n y ECHO -e
echo "=== DIFERENCIAS ENTRE echo, echo -n y echo -e ==="

text="Hola\nmundo"

echo "1. echo normal (agrega salto de línea al final):"
echo "$text"
echo "FIN"

echo
echo "2. echo -n (NO agrega salto de línea al final):"
echo -n "$text"
echo "FIN"

echo
echo "3. echo -e (interpreta secuencias de escape como \\n, \\t, etc):"
echo -e "$text"
echo "FIN"

echo
echo "4. echo -ne (combina ambas opciones):"
echo -ne "$text"
echo "FIN"

echo
echo "=== WC -c (CONTAR CARACTERES) ==="

# wc -c cuenta bytes/caracteres
text1="abc"
text2="abc\n"

echo "Texto sin salto de línea:"
echo -n "$text1" | wc -c  # Resultado: 3

echo "Texto con salto de línea agregado por echo:"
echo "$text1" | wc -c     # Resultado: 4 (incluye el \n que agrega echo)

echo
echo "=== OD -c (MOSTRAR CARACTERES EN OCTAL) ==="

# od -c muestra cada carácter en formato legible, incluyendo caracteres especiales
text3="Hola\tmundo\n"

echo "Contenido visual:"
echo -e "$text3"

echo "Contenido real (od -c muestra cada carácter):"
echo -e "$text3" | od -c

echo
echo "=== EJEMPLO PRÁCTICO ==="

# Demostración práctica de por qué es importante
variable="abc\ndef"

echo "Variable contiene: $variable"
echo "Caracteres sin interpretar secuencias: $(echo -n "$variable" | wc -c)"
echo "Caracteres interpretando secuencias: $(echo -e "$variable" | wc -c)"

echo
echo "Visualización con od -c:"
echo "Sin interpretar:"
echo -n "$variable" | od -c
echo "Interpretando:"
echo -e "$variable" | od -c