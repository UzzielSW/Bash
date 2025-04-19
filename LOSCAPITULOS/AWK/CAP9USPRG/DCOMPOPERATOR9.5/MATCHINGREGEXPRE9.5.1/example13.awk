clear
cat bankpin.lst
echo "El patron  ~/[Cc]urrent/ se debe encerrar entre /  / "
echo "Busca el patron '\$5 ~/[Cc]urrent/'  en el  archivo: bankpin.lst"
echo "Lista las lineas que tienen el patron  que se busca" 
echo
awk ' $5 ~/[Cc]urrent/ ' bankpin.lst
