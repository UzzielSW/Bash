echo ver el nombre de la maquina:
hostname

echo numero serial de la PC:
wmic bios get serialnumber

rem Pausar por 10 seg
timeout /t 10 /nobreak

rem detener por completo
pause>nul