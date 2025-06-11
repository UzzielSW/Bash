: '
 1: Modifica el programa prargs para preceder cada argumento por su numero. Asi, al escribir
 prargs a 'b c' d
 deberia dar la siguiente salida:
 1: a
 2: b c
 3: d
'

i=1
while [ "$#" -ne 0 ]; do
  echo "$i: $1"
  shift
  i=$((i + 1))
done
