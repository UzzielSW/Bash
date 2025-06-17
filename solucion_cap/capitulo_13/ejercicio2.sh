#!/bin/bash
: '
 Solucion para el problema de shar que maneja archivos y directorios
 El script crea un archivo shell que al ejecutarse:
   - Recrea la estructura de directorios necesaria
   - Extrae los archivos en sus rutas correspondientes
 Maneja tanto archivos individuales como directorios completos
 
 Uso: $ shar nombreDirectorio > archivo

 Nota: si no se redirecciona a un archivo solo se imprimira por consola
'

# Validacion de parametros
if [ $# -eq 0 ]; then
  echo "Error: Debe proporcionar al menos un archivo o directorio como argumento" >&2
  echo "Uso: $0 archivo1 [archivo2 ...] directorio1 [directorio2 ...]" >&2
  exit 1
fi

# Funcion para escapar nombres con comillas simples
escape() {
  local str="$1"
  local escaped=""
  # Escapa cada comilla simple: ' -> '\''
  while [[ $str =~ ^([^']*)(')(.*)$ ]]; do
    escaped="$escaped${BASH_REMATCH[1]}'\\''"
    str="${BASH_REMATCH[3]}"
  done
  escaped="$escaped$str"
  printf "%s" "$escaped"
}

declare -A dir_set # Almacena directorios unicos
files=()           # Lista de archivos a incluir

# Procesar cada argumento
for arg in "$@"; do
  if [[ ! -e "$arg" ]]; then
    echo "Error: $arg no existe" >&2
    exit 1
  elif [[ -f "$arg" ]]; then
    # Archivo regular: agregar a la lista
    files+=("$arg")
    dir="$(dirname "$arg")"
    dir_set["$dir"]=1
  elif [[ -d "$arg" ]]; then
    # Directorio: agregar todos sus subdirectorios
    while IFS= read -r dir; do
      [[ -n "$dir" ]] && dir_set["$dir"]=1
    done < <(find "$arg" -type d)
    # Agregar todos sus archivos regulares
    while IFS= read -r file; do
      [[ -n "$file" ]] && files+=("$file")
    done < <(find "$arg" -type f)
  else
    echo "Error: $arg no es un archivo o directorio" >&2
    exit 1
  fi
done

# Encabezado del archivo shar
echo "#"
echo "# Para extraer, ejecutar: sh archivo"
echo "#"

# Crear directorios necesarios
for dir in "${!dir_set[@]}"; do
  safe_dir=$(escape "$dir")
  echo "mkdir -p '${safe_dir}'"
done

# Contador para marcadores unicos
counter=1
for file in "${files[@]}"; do
  safe_file=$(escape "$file")
  marker="END-OF-FILE-$counter"

  # Comandos para extraer el archivo
  echo
  echo "echo Extrayendo '${safe_file}'"
  echo "cat >'${safe_file}' <<'${marker}'"
  cat -- "$file"
  echo "$marker"

  ((counter++))
done
