: '
1: Modify the prargs program to precede each argument by its number. So typing
prargs a 'b c' d
should give the following output:
1: a
2: b c
3: d
'

i=1
while [ "$#" -ne 0 ] 
do
  # echo "numero de argumentos: $#"
  echo "$i: $1" 
  shift
  i=$(( i + 1))
done
