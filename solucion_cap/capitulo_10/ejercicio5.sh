#!/bin/bash
: '
Problema: Agregar una opcion -n a mycp que suprima la verificacion normal
de la existencia de los archivos de destino.

Solucion: Implementar getopts para manejar la opcion -n y omitir la verificacion
de sobrescritura cuando esta activa
'

# Variable global para controlar verificacion de sobrescritura
no_clobber_check=false

# Funcion para solicitar argumentos interactivamente
prompt_for_args() {
  local source_input dest_input

  # Solicitar archivo fuente
  printf "Nombre del archivo fuente? "
  read -r source_input
  [[ -z "$source_input" ]] && {
    echo "Error: Nombre de archivo fuente requerido" >&2
    exit 1
  }

  # Solicitar archivo destino
  printf "Nombre del archivo destino? "
  read -r dest_input
  [[ -z "$dest_input" ]] && {
    echo "Error: Nombre de archivo destino requerido" >&2
    exit 1
  }

  # Expandir patrones glob si existen - usar eval para expansion segura
  eval "source_files=($source_input)"
  to="$dest_input"

  # Configurar arrays globales
  filelist=("${source_files[@]}")
}

# Procesar opciones con getopts
while getopts "n" opt; do
  case $opt in
  n)
    no_clobber_check=true
    ;;
  \?)
    echo "Opcion invalida: -$OPTARG" >&2
    echo "Uso: mycp [-n] archivo1 archivo2" >&2
    echo "     mycp [-n] archivo(s) dir" >&2
    echo "     mycp (modo interactivo)" >&2
    exit 1
    ;;
  esac
done

# Ajustar indices de argumentos despues de procesar opciones
shift $((OPTIND - 1))

# Validacion inicial de argumentos y modo interactivo
if [[ $# -eq 0 ]]; then
  # Modo interactivo - solicitar argumentos
  prompt_for_args
elif [[ $# -lt 2 ]]; then
  echo "Uso: mycp [-n] archivo1 archivo2" >&2
  echo "     mycp [-n] archivo(s) dir" >&2
  echo "     mycp (modo interactivo)" >&2
  exit 1
else
  # Modo normal - usar argumentos de linea de comandos
  to="${@: -1}"
  filelist=("${@:1:$#-1}")
fi

# Validar destino para multiples archivos
if [[ ${#filelist[@]} -gt 1 && ! -d "$to" ]]; then
  echo "Error: El destino debe ser un directorio cuando se copian multiples archivos" >&2
  exit 1
fi

# Arrays para clasificar archivos
existing_files=()
missing_files=()
copylist=()

# Clasificar archivos por existencia - usar comillas en expansiones
for file in "${filelist[@]}"; do
  if [[ -e "$file" ]]; then
    existing_files+=("$file")
  else
    missing_files+=("$file")
  fi
done

# Reportar archivos faltantes - printf protege caracteres especiales
if [[ ${#missing_files[@]} -gt 0 ]]; then
  echo "Advertencia: Los siguientes archivos no existen y seran omitidos:" >&2
  printf "  %s\n" "${missing_files[@]}" >&2
fi

# Salir si no hay archivos validos
if [[ ${#existing_files[@]} -eq 0 ]]; then
  echo "Error: No se encontraron archivos fuente validos" >&2
  exit 1
fi

# Procesar archivos existentes - todas las variables entre comillas
for from in "${existing_files[@]}"; do
  # Determinar archivo destino - basename protegido con comillas
  if [[ -d "$to" ]]; then
    tofile="$to/$(basename "$from")"
  else
    tofile="$to"
  fi

  # Manejar sobrescritura - omitir verificacion si -n esta activo
  if [[ "$no_clobber_check" == true ]]; then
    copylist+=("$from")
  elif [[ -e "$tofile" ]]; then
    printf "%s ya existe; sobrescribir (si/no)? " "$tofile"
    read -r answer
    if [[ $answer =~ ^(s|si)$ ]]; then
      copylist+=("$from")
    fi
  else
    copylist+=("$from")
  fi
done

# Ejecutar copia - expansion de array protegida
if [[ ${#copylist[@]} -gt 0 ]]; then
  if cp "${copylist[@]}" "$to"; then
    echo "Se copiaron exitosamente ${#copylist[@]} archivo(s)"
  else
    echo "Error: La operacion de copiado fallo" >&2
    exit 1
  fi
else
  echo "No se copiaron archivos"
fi
