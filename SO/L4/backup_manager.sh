#!/bin/bash

# Gestor de Copias de Seguridad Selectivas
: '
Este es un script que permite al usuario especificar un directorio de origen, un directorio de destino y un patron de nombres de archivo (**.txt, documento_final.**).

El script buscaria archivos que coincidan con el patron en el origen y sus subdirectorios (hasta cierta profundidad, configurable por parametro), los comprimiria (en un archivo .zip o .tar.gz con fecha y hora) y los moveria al directorio de destino. Registraria cada archivo procesado, el tamaño original, el tamaño comprimido y cualquier error en un archivo de log. Se podrian incluir validaciones para asegurar que los directorios existen y hay suficiente espacio en el destino.
- **Parametros**: Directorio origen, directorio destino, patron de archivo, profundidad de busqueda (opcional).
- **E/S Archivos**: Leer estructura de directorios, leer archivos para comprimir, escribir archivo comprimido, escribir archivo de log.
- **Condicionales/Bucles**: Iterar sobre archivos/directorios, verificar si el archivo coincide con el patron, verificar existencia de directorios.
- **Salida Personalizada**: Mensajes de progreso, resumen en el log, advertencias si no se encuentran archivos o si hay errores de compresion/copia.
'
# --- Configuracion de Salida y Log ---
LOG_FILE="backup_manager_ubuntu.log"
exec > >(tee -a "${LOG_FILE}") 2>&1 # Redirige stdout y stderr al log y a la consola

echo "----------------------------------------------------"
echo "Inicio del Gestor de Copias de Seguridad - $(date)"
echo "----------------------------------------------------"

# --- Funciones Auxiliares ---
log_message() {
  echo "[$(date +'%Y-%m-%d %H:%M:%S')] - $1"
}

show_usage() {
  echo "Uso: $0 <directorio_origen> <directorio_destino> <patron_archivo> [profundidad_maxima]"
  echo "Ejemplo: $0 \"/home/usuario/documentos\" \"/mnt/backup/docs\" \"*.txt\" 2"
  exit 1
}

# --- Validacion de Parametros ---
if [ "$#" -lt 3 ] || [ "$#" -gt 4 ]; then
  log_message "Error: Numero incorrecto de parametros."
  show_usage
fi

SOURCE_DIR="$1"
DEST_DIR="$2"
FILE_PATTERN="$3"
MAX_DEPTH_PARAM=${4:-999} # Profundidad por defecto grande si no se especifica

log_message "Directorio Origen: ${SOURCE_DIR}"
log_message "Directorio Destino: ${DEST_DIR}"
log_message "Patron de Archivo: ${FILE_PATTERN}"
log_message "Profundidad Maxima de Busqueda: ${MAX_DEPTH_PARAM}"

# --- Validaciones de Directorios ---
if [ ! -d "$SOURCE_DIR" ]; then
  log_message "Error: El directorio de origen '$SOURCE_DIR' no existe."
  exit 1
fi

if [ ! -d "$DEST_DIR" ]; then
  log_message "Advertencia: El directorio de destino '$DEST_DIR' no existe. Intentando crear..."
  mkdir -p "$DEST_DIR"
  if [ $? -ne 0 ]; then
    log_message "Error: No se pudo crear el directorio de destino '$DEST_DIR'."
    exit 1
  else
    log_message "Directorio de destino '$DEST_DIR' creado exitosamente."
  fi
fi

# Validacion de espacio (simplificada - verifica si el destino esta montado y es escribible)
# Una verificacion de espacio real requeriria calcular el tamaño total de los archivos a copiar
# y compararlo con el espacio disponible (usando 'df').
if [ ! -w "$DEST_DIR" ]; then
  log_message "Error: No se tienen permisos de escritura en el directorio de destino '$DEST_DIR'."
  exit 1
fi
log_message "Validaciones de directorios completadas."

# --- Logica Principal de Backup ---
TIMESTAMP=$(date +'%Y%m%d_%H%M%S')
ARCHIVE_BASE_NAME="backup_${TIMESTAMP}"

# Creamos un subdirectorio en el destino para esta ejecucion de backup
TARGET_BACKUP_DIR="${DEST_DIR}/${ARCHIVE_BASE_NAME}"
mkdir -p "${TARGET_BACKUP_DIR}"
if [ $? -ne 0 ]; then
  log_message "Error: No se pudo crear el subdirectorio de backup '${TARGET_BACKUP_DIR}'."
  exit 1
fi
log_message "Directorio para esta copia: ${TARGET_BACKUP_DIR}"

processed_files_count=0
total_original_size=0
total_compressed_size=0
errors_count=0

log_message "Iniciando busqueda de archivos..."

# Usamos find para buscar archivos
# -print0 y read -d $'\0' manejan nombres de archivo con espacios o caracteres especiales
find "$SOURCE_DIR" -maxdepth "$MAX_DEPTH_PARAM" -type f -name "$FILE_PATTERN" -print0 | while IFS= read -r -d $'\0' file_path; do
  filename=$(basename "$file_path")
  original_size_bytes=$(stat -c%s "$file_path")
  original_size_human=$(du -h "$file_path" | cut -f1)

  log_message "Procesando archivo: '$file_path' (Tamaño: $original_size_human)"

  # Nombre del archivo comprimido
  # Usaremos tar.gz para este ejemplo en Linux. Se podria usar zip tambien.
  # Para simplicidad, cada archivo coincidente se comprime individualmente.
  # Una alternativa seria comprimirlos todos en un solo gran archivo.
  COMPRESSED_FILE_NAME="${filename}.tar.gz"
  DEST_ARCHIVE_PATH="${TARGET_BACKUP_DIR}/${COMPRESSED_FILE_NAME}"

  # Comprimir el archivo
  # tar: -c crea, -z gzip, -f archivo, -P preserva paths completos (opcional, quitado para que sea relativo al hacer -C)
  # -C cambia al directorio base del archivo para que no se guarde toda la ruta absoluta en el tar
  tar -czf "$DEST_ARCHIVE_PATH" -C "$(dirname "$file_path")" "$filename"

  if [ $? -eq 0 ]; then
    compressed_size_bytes=$(stat -c%s "$DEST_ARCHIVE_PATH")
    compressed_size_human=$(du -h "$DEST_ARCHIVE_PATH" | cut -f1)
    log_message "  Exito: Comprimido a '$DEST_ARCHIVE_PATH' (Tamaño: $compressed_size_human)"

    processed_files_count=$((processed_files_count + 1))
    total_original_size=$((total_original_size + original_size_bytes))
    total_compressed_size=$((total_compressed_size + compressed_size_bytes))
  else
    log_message "  Error: Fallo la compresion del archivo '$file_path'."
    errors_count=$((errors_count + 1))
    # Opcional: eliminar archivo parcialmente comprimido si fallo
    rm -f "$DEST_ARCHIVE_PATH"
  fi
done

log_message "Busqueda y procesamiento de archivos completados."

# --- Resumen ---
log_message "--- RESUMEN DE LA OPERACION ---"
if [ "$processed_files_count" -eq 0 ] && [ "$errors_count" -eq 0 ]; then
  log_message "No se encontraron archivos que coincidan con el patron '$FILE_PATTERN' en '$SOURCE_DIR' hasta la profundidad $MAX_DEPTH_PARAM."
  # Si no se proceso nada, eliminar el directorio de backup de esta ejecucion
  if [ -d "${TARGET_BACKUP_DIR}" ]; then
    if [ ! "$(ls -A ${TARGET_BACKUP_DIR})" ]; then # si esta vacio
      rmdir "${TARGET_BACKUP_DIR}"
      log_message "Directorio de backup vacio ${TARGET_BACKUP_DIR} eliminado."
    fi
  fi
else
  log_message "Archivos procesados exitosamente: $processed_files_count"
  log_message "Tamaño total original: $(numfmt --to=iec-i --suffix=B $total_original_size)"
  log_message "Tamaño total comprimido: $(numfmt --to=iec-i --suffix=B $total_compressed_size)"
  log_message "Errores durante el proceso: $errors_count"
fi
log_message "Log completo disponible en: ${LOG_FILE}"
echo "----------------------------------------------------"
echo "Fin del Gestor de Copias de Seguridad - $(date)"
echo "----------------------------------------------------"

exit 0
