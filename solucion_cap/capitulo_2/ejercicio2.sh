#!/bin/bash

: '
Analisis de efectos de secuencias de comandos Unix/Linux:

1. ls | wc -l                    - Cuenta archivos en directorio actual
2. who | wc -l                   - Cuenta usuarios conectados al sistema
3. ls *.c | wc -l                - Cuenta archivos con extension .c
4. who | sort                    - Lista usuarios conectados ordenados alfabeticamente
5. cp memo1 ..                   - Copia archivo memo1 al directorio padre
6. rm ???                        - Elimina archivos con nombres de 3 caracteres exactos
7. mv progs/* /users/steve/backup - Mueve todos los archivos de progs/ a /users/steve/backup
8. rm *.o                        - Elimina todos los archivos con extension .o
9. cd; pwd                       - Cambia a directorio home y muestra ruta actual
10. plotdata 2>errors &          - Ejecuta plotdata en background redirigiendo stderr
'

# Simulador de efectos de comandos Unix/Linux
simulate_command_effects() {
  local current_dir=$(pwd)
  local home_dir="$HOME"

  echo "=== EFECTOS DE COMANDOS UNIX/LINUX ==="
  echo

  # Comando 1: ls | wc -l
  echo "1. ls | wc -l"
  echo "   Efecto: Cuenta el numero de archivos y directorios en el directorio actual"
  if [[ -d "." ]]; then
    local file_count=$(ls 2>/dev/null | wc -l)
    echo "   Resultado: $file_count elementos"
  fi
  echo

  # Comando 2: who | wc -l
  echo "2. who | wc -l"
  echo "   Efecto: Cuenta el numero de usuarios actualmente conectados al sistema"
  if command -v who >/dev/null 2>&1; then
    local user_count=$(who 2>/dev/null | wc -l)
    echo "   Resultado: $user_count usuarios conectados"
  else
    echo "   Resultado: Comando 'who' no disponible"
  fi
  echo

  # Comando 3: ls *.c | wc -l
  echo "3. ls *.c | wc -l"
  echo "   Efecto: Cuenta archivos con extension .c en directorio actual"
  local c_files=$(ls *.c 2>/dev/null | wc -l)
  echo "   Resultado: $c_files archivos .c encontrados"
  echo

  # Comando 4: who | sort
  echo "4. who | sort"
  echo "   Efecto: Lista usuarios conectados ordenados alfabeticamente"
  if command -v who >/dev/null 2>&1; then
    echo "   Resultado: Lista ordenada de usuarios activos"
  else
    echo "   Resultado: Comando 'who' no disponible"
  fi
  echo

  # Comando 5: cp memo1 ..
  echo "5. cp memo1 .."
  echo "   Efecto: Copia archivo 'memo1' al directorio padre"
  if [[ -f "memo1" ]]; then
    echo "   Resultado: memo1 copiado exitosamente"
  else
    echo "   Resultado: Error - archivo memo1 no existe"
  fi
  echo

  # Comando 6: rm ???
  echo "6. rm ???"
  echo "   Efecto: Elimina archivos con nombres de exactamente 3 caracteres"
  local three_char_files=$(ls ??? 2>/dev/null | wc -l)
  echo "   Resultado: $three_char_files archivos de 3 caracteres seran eliminados"
  echo

  # Comando 7: mv progs/* /users/steve/backup
  echo "7. mv progs/* /users/steve/backup"
  echo "   Efecto: Mueve todos los archivos de directorio 'progs' a '/users/steve/backup'"
  if [[ -d "progs" ]]; then
    local progs_files=$(ls progs/ 2>/dev/null | wc -l)
    echo "   Resultado: $progs_files archivos seran movidos"
  else
    echo "   Resultado: Error - directorio 'progs' no existe"
  fi
  echo

  # Comando 8: rm *.o
  echo "8. rm *.o"
  echo "   Efecto: Elimina archivos con extension .o (archivos objeto)"
  local o_files=$(ls *.o 2>/dev/null | wc -l)
  echo "   Resultado: $o_files archivos .o seran eliminados"
  echo

  # Comando 9: cd; pwd
  echo "9. cd; pwd"
  echo "   Efecto: Cambia al directorio home del usuario y muestra la ruta actual"
  echo "   Resultado: Cambiara a $home_dir y mostrara la ruta"
  echo

  # Comando 10: plotdata 2>errors &
  echo "10. plotdata 2>errors &"
  echo "    Efecto: Ejecuta 'plotdata' en segundo plano redirigiendo errores a 'errors'"
  if command -v plotdata >/dev/null 2>&1; then
    echo "    Resultado: Proceso ejecutandose en background, errores en archivo 'errors'"
  else
    echo "    Resultado: Error - comando 'plotdata' no encontrado"
  fi
}

# Ejecutar simulacion de efectos
simulate_command_effects
