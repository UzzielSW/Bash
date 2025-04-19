cat school.lst
echo "cuenta la cantidad de estudiantes con numero mayor o igual 105"
echo Salida:
echo
 awk  'BEGIN { print "Se encontraron: "
	       i=0 }
	
	 $1 >= 105 { i++ } 
 END { print "Resultado",  i }' school.lst
