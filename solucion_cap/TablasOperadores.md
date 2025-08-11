# Tablas de Operadores

## Tabla de Operadores de Archivos

| OPERADOR | Retorna TRUE (estado de salida 0) Si |
| -------- | ------------------------------------ |
| -d file  | file es un directorio                |
| -e file  | file existe                          |
| -f file  | file es un archivo ordinario         |
| -r file  | file es leido por el proceso         |
| -s file  | file es de longitud no cero          |
| -w file  | file es escribible en el proceso     |
| -x file  | file es ejecutable                   |
| -L file  | file es un enlace simbolico (link)   |

## Operadores Logicos

| OPERADOR | SIGNIFICADO |
| -------- | ----------- |
| -a       | AND         |
| -o       | OR          |
| !        | NOT         |

## Tabla de Operadores de Cadenas

| OPERADOR           | Retorna TRUE (estado de salida) Si              |
| ------------------ | ----------------------------------------------- |
| cadena1 = cadena2  | La cadena1 es identica a la cadena2             |
| cadena1 != cadena2 | La cadena1 no es identica a la cadena2          |
| -n cadena          | La cadena no es nula (puede ser vista por test) |
| -z cadena          | La cadena es nula (puede ser vista por test)    |

## Tabla de Operadores de Enteros

| OPERADOR      | Retorna TRUE (estado de salida 0) Si |
| ------------- | ------------------------------------ |
| int1 -eq int2 | int1 es igual a int2                 |
| int1 -ne int2 | int1 no es igual que int2            |
| int1 -ge int2 | int1 es mayor o igual que int2       |
| int1 -gt int2 | int1 es mayor que int2               |
| int1 -le int2 | int1 es menor o igual que int2       |
| int1 -lt int2 | int1 es menor que int2               |
