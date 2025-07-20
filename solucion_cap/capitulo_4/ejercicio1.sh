#!/bin/bash

# PROBLEMA:
# 1: ¿Que coincidira con las siguientes expresiones regulares?
# x*
# xx*
# x\{1,5\}
# x\{5,\}
# x\{10\}
# [0-9]
# [0-9]*
# [0-9][0-9][0-9]
# [0-9]\{3\}
# [0-9]\{3,5\}
# [0-9]\{1,3\},[0-9]\{3\}
# ^\...
# [A-Za-z_][A-Za-z_0-9]*
# \([A-Za-z0-9]\{1,\}\)\1
# ^Begin$
# ^\(.\).*\1$

# Imprimir explicaciones para cada expresion regular
cat <<'EOF'
 ¿Que coincidira con las siguientes expresiones regulares?
1. x*: Cero o mas caracteres 'x'
2. xx*: Uno o mas caracteres 'x' (una 'x' seguida de cero o mas 'x')
3. x\{1,5\}: Entre 1 y 5 caracteres 'x'
4. x\{5,\}: Cinco o mas caracteres 'x'
5. x\{10\}: Exactamente 10 caracteres 'x'
6. [0-9]: Un solo digito (caracter entre '0'-'9')
7. [0-9]*: Cero o mas digitos
8. [0-9][0-9][0-9]: Tres digitos consecutivos
9. [0-9]\{3\}: Exactamente tres digitos (equivalente al anterior)
10. [0-9]\{3,5\}: Entre 3 y 5 digitos consecutivos
11. [0-9]\{1,3\},[0-9]\{3\}: Entre 1-3 digitos, una coma, seguida de tres digitos
12. ^\...: Linea que comienza con punto literal seguido de dos caracteres cualquiera
13. [A-Za-z_][A-Za-z_0-9]*: Identificador valido (letra/guion bajo seguido de letras, digitos o guiones bajos) (VARIABLE)
14. \([A-Za-z0-9]\{1,\}\)\1: Secuencia alfanumerica repetida (ej: "ab12ab12")
15. ^Begin$: Linea que contiene exactamente "Begin"
16. ^\(.\).*\1$: Linea donde el primer y ultimo caracter son identicos
EOF
