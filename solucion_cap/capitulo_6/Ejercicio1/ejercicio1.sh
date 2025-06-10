# Dado los siguientes asignamientos:
x=*
y=?
z='one
two
three'
now=$(date)
symbol='>'

# y estos archivos en tu directorio actual:
echo "=== Archivos en el directorio actual ==="
echo "Comando: echo *"
echo "Resultado:"
echo *

echo -e "\n=== Ejecutando comandos ==="

echo "Comando: echo *** error ***"
echo "Resultado:"
echo *** error ***

echo -e "\nComando: echo 'Is 5 * 4 > 18 ?'"
echo "Resultado:"
echo 'Is 5 * 4 > 18 ?'

echo -e "\nComando: echo \$x"
echo "Resultado:"
echo $x

echo -e "\nComando: echo What is your name?"
echo "Resultado:"
echo What is your name?

echo -e "\nComando: echo \$y"
echo "Resultado:"
echo $y

echo -e "\nComando: echo Would you like to play a game?"
echo "Resultado:"
echo Would you like to play a game?

echo -e "\nComando: echo \"\$y\""
echo "Resultado:"
echo "$y"

echo -e "\nComando: echo \*\*\*"
echo "Resultado:"
echo \*\*\*

echo -e "\nComando: echo \$z | wc -l"
echo "Resultado:"
echo $z | wc -l

echo -e "\nComando: echo \$\$symbol"
echo "Resultado:"
echo \$$symbol

echo -e "\nComando: echo \"\$z\" | wc -l"
echo "Resultado:"
echo "$z" | wc -l

echo -e "\nComando: echo \$\$symbol"
echo "Resultado:"
echo $\$symbol

echo -e "\nComando: echo '\$z' I wc -l"
echo "Resultado:"
echo '$z' I wc -l

echo -e "\nComando: echo \"\\\""
echo "Resultado: unexpected EOF while looking for matching \`\"'"
# echo "\"

echo -e "\nComando: echo _\$now_"

echo _$now_

echo -e "\nComando: echo \"\\\\\""
echo "Resultado:"
echo "\\"

echo -e "\nComando: echo hello \$symbol out"
echo "Resultado:"
echo hello $symbol out

echo -e "\nComando: echo \\\\"
echo "Resultado:"
echo \\

echo -e "\nComando: echo \"\\\"\""
echo "Resultado:"
echo "\""
