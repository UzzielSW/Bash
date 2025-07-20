## Variables de AWK

| Nombre           | Contenido                                                                                                                                                     |
| :--------------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| **ARGC**         | Número de argumentos de la línea de comandos.                                                                                                                 |
| **ARGIND**       | Índice en **ARGV** del archivo actual que se está procesando desde la línea de comandos (solo gawk).                                                          |
| **ARGV**         | Array de argumentos de la línea de comandos.                                                                                                                  |
| **CONVFMT**      | Formato de conversión para números, `%.6g` por defecto (solo gawk).                                                                                           |
| **ENVIRON**      | Un array que contiene los valores de las variables de entorno actuales.                                                                                       |
| **ERRNO**        | Contiene una cadena que describe un error del sistema que ocurre por redirección al leer desde la función `getline` o al usar la función `close` (solo gawk). |
| **FIELDSWIDTHS** | Una lista de anchos de campo separados por espacios utilizada por **FS** al dividir registros de ancho de campo fijo (solo gawk).                             |
| **FNR**          | Número de registro en el archivo actual.                                                                                                                      |
| **FS**           | El separador de campo de entrada, por defecto un espacio.                                                                                                     |
| **IGNORECASE**   | Desactiva la distinción entre mayúsculas y minúsculas en expresiones regulares y operaciones de cadena (solo gawk).                                           |
| **NF**           | Número de campos en el registro actual.                                                                                                                       |
| **NR**           | Número de registros hasta el momento.                                                                                                                         |
| **OFMT**         | Formato de salida para números.                                                                                                                               |
| **OFS**          | Separador de campo de salida.                                                                                                                                 |
| **ORS**          | Separador de registro de salida.                                                                                                                              |
| **RLENGTH**      | Longitud de la cadena que coincide con la función `match`.                                                                                                    |
| **RS**           | Separador de registro de entrada.                                                                                                                             |
| **RSTART**       | Desplazamiento de la cadena que coincide con la función `match`.                                                                                              |
| **RT**           | El terminador de registro; gawk lo establece al texto de entrada que coincidió con el carácter o la expresión regular especificada por **RS**.                |
| **SUBSEP**       | Separador de subíndices.                                                                                                                                      |
