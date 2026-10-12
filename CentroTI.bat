@echo off
chcp 65001 >nul
color 1b
title AegisTI *** Centro de Mantenimiento TI ***
set reporte=%USERPROFILE%\inventario_AegisTI_%RANDOM%.txt
set html=%USERPROFILE%\bateria_AegisTI.html

:menu
cls
color 1b
echo ================================================================
echo             CENTRO DE MANTENIMIENTO TI  -  AegisTI
echo ================================================================
echo   Equipo: %COMPUTERNAME%    Usuario: %USERNAME%
echo ----------------------------------------------------------------
echo   1. Ficha tecnica del equipo
echo   2. Diagnostico de conectividad
echo   3. Energia y rendimiento
echo   4. Limpieza de temporales
echo   5. Inventario del equipo en un archivo
echo   6. Salir
echo ================================================================
echo.
set /p opcion=Digite el numero de la opcion y pulse ENTER:

if "%opcion%"=="1" goto ficha
if "%opcion%"=="2" goto conectividad
if "%opcion%"=="3" goto energia
if "%opcion%"=="4" goto limpieza
if "%opcion%"=="5" goto inventario
if "%opcion%"=="6" goto salir

echo.
echo   Opcion no valida, intente de nuevo.
start rundll32 user32.dll MessageBeep
timeout /t 2 >nul
goto menu

:ficha
cls
color 3f
echo ================ FICHA TECNICA DEL EQUIPO ================
echo.
echo   Nombre del equipo .......... %COMPUTERNAME%
echo   Usuario .................... %USERNAME%
echo   Nucleos logicos ............ %NUMBER_OF_PROCESSORS%
echo   Arquitectura ............... %PROCESSOR_ARCHITECTURE%
echo   Carpeta de Windows ......... %SystemRoot%
echo.
echo   Version de Windows:
ver
echo.
echo   Unidades detectadas:
for %%u in (C D E F G H) do if exist %%u:\ echo      - Unidad %%u: disponible
echo.
for /f %%n in ('driverquery /nh ^| find /c /v ""') do echo   Controladores instalados .... %%n
echo.
pause
goto menu

:conectividad
cls
color 2f
echo ============== DIAGNOSTICO DE CONECTIVIDAD ===============
echo.
echo   Probando la conexion con tres destinos...
echo.
for %%s in (8.8.8.8 google.com www.ufps.edu.co) do (
   ping -n 2 %%s | find "TTL=" >nul
   if errorlevel 1 (
      echo      %%s .......... SIN RESPUESTA
   ) else (
      echo      %%s .......... CONECTADO
   )
)
echo.
set /p destino=Destino para ver la ruta con TRACERT (ENTER para omitir):
if "%destino%"=="" goto menu
tracert -d -h 15 %destino%
set destino=
echo.
pause
goto menu

:energia
cls
color 5f
echo ================= ENERGIA Y RENDIMIENTO ==================
echo.
echo   Generando el informe de bateria...
powercfg /batteryreport /output "%html%" >nul 2>nul
if exist "%html%" (
   echo   Informe creado. Abriendolo en el navegador...
   start "" "%html%"
) else (
   echo   Este equipo no tiene bateria o no se pudo crear el informe.
)
echo.
echo   Planes de energia del equipo:
powercfg /list
echo.
set /p alto=Desea activar el plan de Alto rendimiento (S/N):
if /i "%alto%"=="S" powercfg /setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c
if /i "%alto%"=="S" powercfg /list
set alto=
echo.
pause
goto menu

:limpieza
cls
color 6f
echo ================ LIMPIEZA DE TEMPORALES ==================
echo.
for /f %%n in ('dir /b "%TEMP%" 2^>nul ^| find /c /v ""') do set antes=%%n
echo   Elementos en la carpeta TEMP: %antes%
echo.
set /p confirmar=Desea limpiarla ahora (S/N):
if /i not "%confirmar%"=="S" goto menu
del /q /f "%TEMP%\*" >nul 2>nul
for /f "delims=" %%d in ('dir /ad /b "%TEMP%" 2^>nul') do rd /s /q "%TEMP%\%%d" >nul 2>nul
for /f %%n in ('dir /b "%TEMP%" 2^>nul ^| find /c /v ""') do set despues=%%n
echo.
echo   Antes: %antes% elementos    Despues: %despues% elementos
echo   Los que quedan estan en uso por algun programa.
set confirmar=
echo.
pause
goto menu

:inventario
cls
color 0a
echo ================= INVENTARIO DEL EQUIPO ==================
echo.
echo   Recopilando controladores y procesos, espere...
(
echo ===== INVENTARIO AegisTI  -  %DATE% %TIME% =====
echo Equipo: %COMPUTERNAME%   Usuario: %USERNAME%
ver
echo.
echo ===== CONTROLADORES INSTALADOS =====
driverquery
echo.
echo ===== PROCESOS EN EJECUCION =====
tasklist
) > "%reporte%"
echo   Inventario guardado en:
echo   %reporte%
start rundll32 user32.dll MessageBeep
start "" notepad "%reporte%"
echo.
pause
goto menu

:salir
cls
color 0b
echo.
echo   Gracias por usar AegisTI. Hasta pronto.
echo.
timeout /t 3 >nul
exit
