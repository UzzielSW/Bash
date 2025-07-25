# Programa que obtiene el tiempo de usuario en un sistema

terminal=$(who | grep "$1" | tr -s ' ' ' ' | cut -d' ' -f2)

for var in $terminal; do
  hora_entrada=$(who | grep "$1" | grep "$var" | tr -s '\11' ' ' | cut -d' ' -f4 | cut -c1,2)
  hora_salida=$(date +%H)
  minuto_entrada=$(who | grep "$1" | grep "$var" | tr -s '\11' ' ' | cut -d' ' -f4 | cut -c4,5)
  minuto_salida=$(date +%M)
  hora_total=$(expr "$hora_salida" - "$hora_entrada")
  minuto_total=$(expr "$minuto_salida" - "$minuto_entrada")
  if [ "$minuto_entrada" -eq "$minuto_salida" ]; then
    hora_total=1
    minuto_total=00
    echo "_________________________________________________________________"
    echo El usuario $1 entro al sistema a las $hora_entrada:$minuto_entrada
    echo El usuario $1 ha operado $hora_total:$minuto_total en la terminal "$var"
    echo "_________________________________________________________________"
    echo
    exit 1
  fi
  if [ "$minuto_entrada" -lt "$minuto_salida" ]; then
    minuto_total=$(expr "$minuto_salida" - "$minuto_entrada")

    if [ "$minuto_total" -lt 10 ]; then
      echo "_________________________________________________________________"
      echo El usuario $1 entro al sistema a las $hora_entrada:$minuto_entrada
      echo El usuario $1 ha operado $hora_total:0$minuto_total en la terminal "$var"
      echo "_________________________________________________________________"
      echo
    else
      echo "_________________________________________________________________"
      echo El usuario $1 entro al sistema a las $hora_entrada:$minuto_entrada
      echo El usuario $1 ha operado $hora_total:$minuto_total en la terminal "$var"
      echo "_________________________________________________________________"
      echo
    fi

  else
    min1=$(expr "$minuto_entrada" - "$minuto_salida")
    min2=$(echo $min1 | sed 's/-//')
    min=$(expr 60 - "$min2")
    hora=$(expr $hora_total - 1)
    if [ "$min" -lt 10 ]; then
      echo "_________________________________________________________________"
      echo El usuario $1 entro al sistema a las $hora_entrada:$minuto_entrada
      echo El usuario $1 ha operado $hora:0$min en la terminal "$var"
      echo "_________________________________________________________________"
      echo
    else
      echo "_________________________________________________________________"
      echo El usuario $1 entro al sistema a las $hora_entrada:$minuto_entrada
      echo El usuario $1 ha operado $hora:$min en la terminal "$var"
      echo "_________________________________________________________________"
      echo
    fi

  fi
done
