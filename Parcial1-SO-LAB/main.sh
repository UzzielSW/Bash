echo "PARCIAL 1"

echo "_____________________"
echo "Ejecucion Script 1"
echo "_____________________"
./script1.sh
echo

echo "_____________________"
echo "Ejecucion Script 2"
echo "_____________________"
./script2.sh
echo "_____________________"
echo

echo "_____________________"
echo "Mostrandondo directorio actual: (pwd)"
echo "_____________________"
pwd
echo
echo "_____________________"
echo

read pause
cd ..
cp -r Parcial1 Parcial1c
echo "_________Directorio Actual____________"
ls
echo
echo "_____________________"
echo "Eliminando el directorio Parcial1c (copia de Parcial1)"
echo "_____________________"
rm -rf Parcial1c
echo
echo "_________Directorio Actual____________"
ls
echo "_____________________"
echo

echo "Desea cerrar sesion? (s/n)"
read respuesta

if [ "$respuesta" = "s" ]; then
    echo "Cerrando sesion..."
    cmd.exe /C logoff
    exit 0
else
    echo "Sesion no cerrada."
fi