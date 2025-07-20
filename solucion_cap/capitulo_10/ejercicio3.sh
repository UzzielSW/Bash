#!/bin/bash
: '
Problema: Escribir un programa llamado mymv que haga con el comando mv lo que
mycp hace con el comando cp. Cuantos cambios tuviste que hacer a mycp para
producir este nuevo programa?

Solucion: Cambiar cp por mv y ajustar mensajes. Solo 4 cambios minimos necesarios:
1. Nombres en mensajes de uso
2. Mensaje de error de destino
3. Comando cp por mv
4. Mensaje de confirmacion final
'

# Validacion inicial de argumentos
if [[ $# -lt 2 ]]; then
  echo "Uso: mymv archivo1 archivo2" >&2
  echo "     mymv archivo(s) dir" >&2
  exit 1
fi

# Separar argumentos - usar comillas para proteger caracteres especiales
to="${@: -1}"
filelist=("${@:1:$#-1}")

# Validar destino para multiples archivos
if [[ $# -gt 2 && ! -d "$to" ]]; then
  echo "Error: El destino debe ser un directorio cuando se mueven multiples archivos" >&2
  exit 1
fi

# Arrays para clasificar archivos
existing_files=()
missing_files=()
movelist=()

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

  # Manejar sobrescritura - printf protege nombres con caracteres especiales
  if [[ -e "$tofile" ]]; then
    printf "%s ya existe; sobrescribir (si/no)? " "$tofile"
    read -r answer
    if [[ $answer =~ ^(s|si)$ ]]; then
      movelist+=("$from")
    fi
  else
    movelist+=("$from")
  fi
done

# Ejecutar movimiento - expansion de array protegida
if [[ ${#movelist[@]} -gt 0 ]]; then
  if mv "${movelist[@]}" "$to"; then
    echo "Se movieron exitosamente ${#movelist[@]} archivo(s)"
  else
    echo "Error: La operacion de movimiento fallo" >&2
    exit 1
  fi
else
  echo "No se movieron archivos"
fi
