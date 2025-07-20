#!/bin/bash

: '
Problema: Que pasa con mycp si uno de los nombres de archivo contiene un caracter
que tiene un significado especial para el shell como ; o |?

Solucion: Usar comillas dobles consistentemente en todas las expansiones de variables
y arrays para prevenir la interpretacion de caracteres especiales por el shell
'

# Validacion inicial de argumentos
if [[ $# -lt 2 ]]; then
  echo "Uso: mycp archivo1 archivo2" >&2
  echo "       mycp archivo(s) dir" >&2
  exit 1
fi

# Separar argumentos - usar comillas para proteger caracteres especiales
to="${@: -1}"
filelist=("${@:1:$#-1}")

# Validar destino para multiples archivos
if [[ $# -gt 2 && ! -d "$to" ]]; then
  echo "Error: El destino debe ser un directorio cuando se copian múltiples archivos" >&2
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
  echo "Advertencia: Los siguientes archivos no existen y serán omitidos:" >&2
  printf "  %s\n" "${missing_files[@]}" >&2
fi

# Salir si no hay archivos validos
if [[ ${#existing_files[@]} -eq 0 ]]; then
  echo "Error: No se encontraron archivos fuente válidos" >&2
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

  # Manejar sobrescritura - printf protege nombres con caracteres especiales
  if [[ -e "$tofile" ]]; then
    printf "%s ya existe; ¿sobrescribir (si/no)? " "$tofile"
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
    echo "Error: La operación de copiado falló" >&2
    exit 1
  fi
else
  echo "No se copiaron archivos"
fi
