REM https://todohacker.com/tutoriales/lenguaje-batch
@REM se usa para evitar que se muestren los comandos en la consola
echo off

set fecha=%date%
set hora=%time%

echo Fecha actual: %fecha% > ar.txt
REM echo  >> ar.txt 
echo Hora: %hora% > ar.txt
REM echo  >> ar.txt 
echo se ingreso correctamente la informacion en el archivo
REM salto de linea:
REM echo.

echo Ingrese su nombre:
set /P nombre=

echo Nombre de User: %nombre% > ar2.txt
REM echo  >> ar2.txt
echo se ingreso correctamente la informacion en el archivo
REM echo.

REM Borrando archivo
del ar.txt
del ar2.txt

REM renombrar un archivo
REM move /y lab4-opera_math.bat operaciones_basicas.txt

pause>nul