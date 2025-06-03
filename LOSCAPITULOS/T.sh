: '
Escribe un programa llamado «t» que muestre la hora del día en notación a.m. o p.m. en lugar de en hora de reloj de 24 horas. Aquí hay un ejemplo que muestra t ejecutado por la noche:
$ date
Wed Aug 28 19:21:01 EDT 2002
$ t
7:21 pm
$
'

echo "Date Horizontal: $(date)"
echo
echo "____Date Vertical____"
date | tr -s ' ' '\12'
echo "_____________________"
echo
echo "Hora Completa: $(date | cut -d' '  -f5)"
echo "Hora en formato 12 horas: $(date +"%I:%M %p")"
echo "Hora: $(date | cut -d' '  -f5 | cut -d: -f1)"
echo "Minutos: $(date | cut -d' '  -f5 | cut -d: -f2)"
echo "Segundos: $(date | cut -d' '  -f5 | cut -d: -f3)"

# Implementación utilizando aritmética de enteros y un comando case para convertir la hora de 24 horas a 12 horas con notación a.m./p.m.
current_hour=$(date +"%H")
current_minute=$(date +"%M")

# Convertir la hora de 24 horas a 12 horas
echo "_____________________"
echo
echo "Solución con aritmética de enteros y case:"

# si es media noche
if [ "$current_hour" -eq 0 ]; then
    hour=12
    period="a.m."
    # si es antes del mediodía
    elif [ "$current_hour" -lt 12 ]; then
    hour=$current_hour
    period="a.m."
    # si son las 12 del mediodía
    elif [ "$current_hour" -eq 12 ]; then
    hour=12
    period="p.m."
    # si es después del mediodía
else
    hour=$((current_hour - 12))
    # hour=$(expr $current_hour - 12) # Alternativa usando expr
    period="p.m."
fi

# Usar un comando case para mostrar la hora
case $hour in
    1|2|3|4|5|6|7|8|9|10|11|12)
        echo "Hora actual: $hour:$current_minute $period"
    ;;
    *)
        echo "Error al calcular la hora."
    ;;
esac