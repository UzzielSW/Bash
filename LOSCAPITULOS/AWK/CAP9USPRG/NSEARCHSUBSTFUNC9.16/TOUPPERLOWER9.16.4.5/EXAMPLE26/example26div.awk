clear
echo " El siguiente script alterna entre mayúsculas y caracteres en el archivo, 
es decir, los caracteres en minúsculas se convierten a mayúsculas y los caracteres 
en mayúsculas se convierten a minúsculas.   "
echo togglecase.awk
cat togglecase.awk
awk -f togglecase.awk text.lst
