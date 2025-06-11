#!/bin/bash

: '
 Escribir un programa llamado mysed que aplique el script sed dado como primer
 argumento al archivo dado como segundo argumento. Si sed ejecuta exitosamente
 (codigo de salida cero), reemplazar el archivo original con el modificado.

 Ejemplo: mysed '1,10d' text

 Usara sed para eliminar las primeras 10 lineas de text, y si es exitoso,
 reemplazara text con el archivo modificado.
'

# Verificar numero correcto de argumentos
[[ $# -ne 2 ]] && {
    echo "Uso: $0 'script_sed' archivo" >&2
    exit 1
}

sed_script="$1"
archivo="$2"

# Verificar que el archivo existe y es legible
[[ ! -r "$archivo" ]] && {
    echo "Error: No se puede leer el archivo '$archivo'" >&2
    exit 1
}

# Crear archivo temporal en el mismo directorio para garantizar atomicidad
temp_file=$(mktemp "${archivo}.XXXXXX") || {
    echo "Error: No se pudo crear archivo temporal" >&2
    exit 1
}

# Limpiar archivo temporal al salir
trap 'rm -f "$temp_file"' EXIT

# Aplicar sed y verificar exito
if sed "$sed_script" "$archivo" >"$temp_file"; then
    # Si sed fue exitoso, reemplazar archivo original
    mv "$temp_file" "$archivo" || {
        echo "Error: No se pudo reemplazar el archivo" >&2
        exit 1
    }
else
    # Si sed fallo, mantener archivo original
    echo "Error: Fallo al aplicar sed" >&2
    exit 1
fi
