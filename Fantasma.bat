@echo off
chcp 65001 >nul
color 0a
title Simbolo del sistema

cls
echo.
echo   Este es un experimento EDUCATIVO de Sistemas Operativos.
echo   Hara travesuras inofensivas y al final todo vuelve a la normalidad.
echo.
set /p ok=Escribe SI para invocar al fantasma (ENTER para salir):
if "%ok%"=="SI" goto inicio
if "%ok%"=="si" goto inicio
echo.
echo   ...el fantasma se queda dormido. Adios.
timeout /t 2 >nul
exit

:inicio
set nota=%USERPROFILE%\Desktop\nota_del_fantasma.txt
if not exist "%USERPROFILE%\Desktop" set nota=%TEMP%\nota_del_fantasma.txt

cls
color 02
echo   .
timeout /t 1 >nul
echo   . .
timeout /t 1 >nul
echo   . . .
timeout /t 1 >nul
cls
color 0a
echo.
echo   ##################################################
echo   #                                                #
echo   #      Boo...  he tomado el control del CMD      #
echo   #            (tranquilo, soy amable)             #
echo   #                                                #
echo   ##################################################
start rundll32 user32.dll MessageBeep
timeout /t 3 >nul

for /l %%c in (1,1,6) do (
   color 0%%c
   title Fantasma en el sistema... %%c
   timeout /t 1 >nul
)
color 0a
title Fantasma en el sistema

echo.
echo   [Fantasma] Ahora intercambio los botones de tu raton...
rundll32 user32.dll,SwapMouseButton
start rundll32 user32.dll MessageBeep
echo   Prueba hacer clic en algo... raro, verdad?
timeout /t 8 >nul

echo.
echo   [Fantasma] Soltando fantasmitas...
for /l %%g in (1,1,6) do (
   start "FANTASMITA" cmd /c "color %%gf & echo. & echo    ~ Boo %%g ~ & timeout /t 5 >nul"
   start rundll32 user32.dll MessageBeep
   timeout /t 1 >nul
)

echo Estuve aqui... el Fantasma Educado (o.o) > "%nota%"
echo No te preocupes: no rompi nada. >> "%nota%"
echo En unos segundos me llevo esta nota conmigo. >> "%nota%"
echo.
echo   [Fantasma] Te deje una nota...
start "" notepad "%nota%"

echo.
for /l %%t in (6,-1,1) do (
   echo   Revirtiendo todo en %%t...
   start rundll32 user32.dll MessageBeep
   timeout /t 1 >nul
)

echo.
echo   [Fantasma] Cerrando a los fantasmitas...
taskkill /f /fi "WINDOWTITLE eq FANTASMITA*" >nul 2>nul
echo   [Fantasma] Quitando la nota...
taskkill /fi "WINDOWTITLE eq nota_del_fantasma*" >nul 2>nul
del /q "%nota%" >nul 2>nul
timeout /t 2 >nul

cls
color 0e
echo   ================================================================
echo     ULTIMO PASO: devolver los botones del raton
echo   ================================================================
echo.
echo   Se abrira la ventana Propiedades del mouse.
echo   OJO: ahora el clic principal es el boton DERECHO.
echo.
echo   1. Marca y desmarca la casilla "Intercambiar botones primario
echo      y secundario" hasta que quede SIN marcar.
echo   2. Pulsa Aceptar.
echo.
echo   Tambien puedes usar el teclado: Tab para moverte, Espacio para
echo   marcar o desmarcar y Enter para aceptar.
echo.
echo   Si cierras esta bateria antes de tiempo, reinicia o cierra
echo   sesion: el cambio no se guarda y el raton vuelve a la normalidad.
echo.
pause
control mouse
echo.
echo   Cuando el raton funcione normal, pulsa una tecla.
pause >nul

cls
color 0b
title Sorpresa
echo.
echo   ================================================================
echo     Todo quedo como estaba. Gracias por jugar.
echo   ================================================================
echo.
echo   LECCION: un .bat puede cambiar el raton, abrir y cerrar
echo   procesos, crear y borrar archivos... por eso NUNCA debes
echo   ejecutar un .bat de origen desconocido. Un atacante haria
echo   lo mismo SIN avisar y SIN revertirlo. La diferencia es la etica.
echo.
echo     - El Fantasma Educado se despide.
echo.
start rundll32 user32.dll MessageBeep
pause >nul
color 07
title Simbolo del sistema
exit
