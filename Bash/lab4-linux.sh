#! /bin/bash
clear
numA=$1
numB=$2
numC=$3

echo "numeros A=$numA y B=$numB y C=$numC"
# echo "la calculadora de Areas funciona solo con introducir dos numeros, el programa realizara las respectivas operaciones de acuerdo a las formulas correspondientes"
echo "agreguen 0 en los numeros que no vaya a usar"
echo "area de un cuadrado a^2 = " $((numA*numA))
echo "area de un triangulo b*h/2 = " $((numA*numB/2))
echo "area de un trapecio B+b*h/2 = " $((numA+numB*numC/2))
echo "area de un rombo D*d/2 = " $((numA*numB/2))
echo "area de un rectangulo b*h = " $((numA*numB))
echo "area de un paralelogramo b*h = " $((numA*numB))
echo "area de un romboide b*h = " $((numA*numB))