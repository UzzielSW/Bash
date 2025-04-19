clear
cat school.lst
echo
echo "cuenta la cantidad de estudiantes de commerces"
echo Salida
awk ' $3 == "commerce" { i++ ; print NR,$0}; END { print "Resultado: " i}' school.lst
