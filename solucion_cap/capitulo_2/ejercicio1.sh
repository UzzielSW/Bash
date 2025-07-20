: ' 1. Dados los siguientes archivos en su directorio actual
   $ ls
   feb96
   jan12.02
   jan19.02
   jan26.02
   jan5.02
   jan95
   jan96
   jan97
   jan98
   mar98
   memo1
   memo10
   memo2
   memo2.sv
   $
'

echo "1. Comando: echo *"
echo *
# todos

echo -e "\n2. Comando: echo *[!0-9]"
echo *[!0-9]
# todos los que no terminen en numero

echo -e "\n3. Comando: echo m[a-df-z]*"
echo m[a-df-z]*
# mar98

echo -e "\n4. Comando: echo [A-Z]*"
echo [A-Z]*
# no muestra nada

echo -e "\n5. Comando: echo jan*"
echo jan*
# todos los que empiezan por jan

echo -e "\n6. Comando: echo *.*"
echo *.*
# todos los que tienen extension

echo -e "\n7. Comando: echo ?????"
echo ?????
# todos los que tienen 5 caracteres

echo -e "\n8. Comando: echo *02"
echo *02
# todos los que terminen en 02

echo -e "\n9. Comando: echo jan?? feb?? mar??"
echo jan?? feb?? mar??
# todos los que tengan 4 caracteres y empiezan por jan o feb o mar

echo -e "\n10. Comando: echo [fjm][ae][bnr]*"
echo [fjm][ae][bnr]*
# feb96 jan12.02 jan19.02 jan26.02 jan5.02 jan95 jan96 jan97 jan98 mar98 memo1 memo10 memo2 memo2.sv
