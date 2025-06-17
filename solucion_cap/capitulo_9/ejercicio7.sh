#!/bin/bash
: '
 wgrep: Busca un patron en un archivo con ventana configurable. Modifica wgrep
 para tomar una opcion -w opcional que especifica el tamano de la ventana.
 "wgrep -w 3 UNIX text" debe imprimir tres lineas antes y despues de cada linea
 de text que contenga el patron UNIX.
'

window_size=1
pattern=""
file=""

# Procesa las opciones de linea de comandos
while getopts "w:" option; do
  case "$option" in
  w) window_size="$OPTARG" ;;
  \?)
    echo "USO: $0 [-w numero] patron archivo"
    echo "  -w  tamano de ventana (defecto: 1)"
    exit 1
    ;;
  esac
done

# Valida que el tamano de ventana sea un numero valido
if [[ ! "$window_size" =~ ^[0-9]+$ ]] || [[ "$window_size" -eq 0 ]]; then
  echo "Error: El tamano de ventana debe ser un numero entero positivo"
  exit 1
fi

# Obtiene los argumentos restantes
shift $((OPTIND - 1))

# Verifica argumentos
if [[ $# -ne 2 ]]; then
  echo "USO: $0 [-w numero] patron archivo"
  exit 1
fi

pattern="$1"
file="$2"

# Verifica que el archivo existe y es legible
if [[ ! -f "$file" ]]; then
  echo "Error: $file no existe o no es un archivo regular"
  exit 1
fi

if [[ ! -r "$file" ]]; then
  echo "Error: No se puede leer el archivo $file"
  exit 1
fi

# Lee todas las lineas del archivo en un array
mapfile -t lines <"$file"
total_lines=${#lines[@]}
found_match=false
printed_lines=()

# Busca coincidencias y marca las lineas a imprimir
for ((i = 0; i < total_lines; i++)); do
  if [[ "${lines[i]}" =~ $pattern ]]; then
    found_match=true

    # Calcula el rango de lineas a imprimir
    start=$((i - window_size))
    end=$((i + window_size))

    # Ajusta los limites al archivo
    [[ $start -lt 0 ]] && start=0
    [[ $end -ge $total_lines ]] && end=$((total_lines - 1))

    # Marca las lineas en el rango para imprimir
    for ((j = start; j <= end; j++)); do
      printed_lines[j]=1
    done
  fi
done

# Imprime las lineas marcadas con separadores
if [[ "$found_match" == true ]]; then
  in_group=false

  for ((i = 0; i < total_lines; i++)); do
    if [[ "${printed_lines[i]}" == 1 ]]; then
      # Si empezamos un nuevo grupo, no imprimimos separador
      if [[ "$in_group" == false ]]; then
        in_group=true
      fi
      echo "${lines[i]}"
    else
      # Si terminamos un grupo, imprimimos separador
      if [[ "$in_group" == true ]]; then
        echo "--"
        in_group=false
      fi
    fi
  done

  # Separador final si terminamos en un grupo
  if [[ "$in_group" == true ]]; then
    echo "--"
  fi
fi

# Codigo de salida
if [[ "$found_match" == true ]]; then
  exit 0
else
  exit 1
fi
