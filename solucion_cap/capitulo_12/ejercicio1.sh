#!/bin/bash

: '
 Analisis de expansiones de parametros en Bash con diferentes operadores
 Dadas las siguientes asignaciones de variables:
   EDITOR=/bin/vi
   DB=
   EDITFLAG=yes
   PHONEBOOK=
 Se evaluan los resultados de diferentes comandos de expansion de parametros
'

# Establecer las variables tal como se especifica en el problema
EDITOR=/bin/vi
DB=
EDITFLAG=yes
PHONEBOOK=

echo "=== Analisis de expansiones de parametros ==="
echo

# Comando 1: ${EDITOR}
# Expande al valor de EDITOR, que es "/bin/vi"
echo "echo \${EDITOR}:"
echo ${EDITOR}
echo

# Comando 2: ${EDITOR:-/bin/ed}
# Si EDITOR esta definido y no vacio, usa su valor; sino usa "/bin/ed"
# Como EDITOR="/bin/vi", resultado: "/bin/vi"
echo "echo \${EDITOR:-/bin/ed}:"
echo ${EDITOR:-/bin/ed}
echo

# Comando 3: ${DB:-/users/pat/db}
# Si DB esta definido y no vacio, usa su valor; sino usa "/users/pat/db"
# Como DB="", resultado: "/users/pat/db"
echo "echo \${DB:-/users/pat/db}:"
echo ${DB:-/users/pat/db}
echo

# Comando 4: ${DB:=/users/pat/db}
# Si DB esta definido y no vacio, usa su valor; sino asigna y usa "/users/pat/db"
# Como DB="", asigna "/users/pat/db" a DB y lo muestra
echo "echo \${DB:=/users/pat/db}:"
echo ${DB:=/users/pat/db}
echo "DB despues de la asignacion: $DB"
echo

# Comando 5: ${PHONEBOOK:?}
# Si PHONEBOOK esta definido y no vacio, usa su valor; sino genera error
# Como PHONEBOOK="", generara error y terminara el script
echo "echo \${PHONEBOOK:?}:"
echo "Este comando generara un error porque PHONEBOOK esta vacio:"
# Capturar el error para no terminar el script
if ! result=$(echo ${PHONEBOOK:?} 2>&1); then
  echo "Error capturado: $result"
fi
echo

# Comando 6: ed=${EDITFLAG:+${EDITOR:-/bin/ed}}
# Si EDITFLAG esta definido y no vacio, usa ${EDITOR:-/bin/ed}; sino usa ""
# Como EDITFLAG="yes", evalua ${EDITOR:-/bin/ed} que resulta en "/bin/vi"
echo "ed=\${EDITFLAG:+\${EDITOR:-/bin/ed}}:"
ed=${EDITFLAG:+${EDITOR:-/bin/ed}}
echo "Valor asignado a ed: $ed"
