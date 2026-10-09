@echo off
:: Conditionnement - Configuration du mode kiosque
:: Remplace le shell Windows par le script kiosk-loop.bat pour l'utilisateur actuel.
:: A executer SUR LE COMPTE KIOSQUE, sans "Executer en tant qu'administrateur" :
:: la cle de registre est celle de l'utilisateur courant (HKCU).

echo ============================================
echo  Conditionnement - Configuration Kiosque
echo ============================================
echo.

:: Verifier que l'application est installee pour ce compte
set APP_EXE=%LOCALAPPDATA%\Programs\Conditionnement\Conditionnement.exe
if not exist "%APP_EXE%" (
    echo ERREUR : Conditionnement n'est pas installe pour le compte "%USERNAME%" :
    echo   %APP_EXE%
    echo Installez l'application en etant connecte sur ce compte, puis relancez ce script.
    pause
    exit /b 1
)

:: Copier le script de boucle a cote de l'application
set LOOP_SRC=%~dp0kiosk-loop.bat
set LOOP_DST=%LOCALAPPDATA%\Programs\Conditionnement\kiosk-loop.bat

echo Copie du script de boucle...
copy /y "%LOOP_SRC%" "%LOOP_DST%" >nul
if %errorlevel% neq 0 (
    echo ERREUR : Impossible de copier kiosk-loop.bat.
    pause
    exit /b 1
)

:: Remplacer le shell pour l'utilisateur actuel
echo Configuration du shell de remplacement...
reg add "HKCU\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /v Shell /t REG_SZ /d "\"%LOOP_DST%\"" /f >nul

echo.
echo Configuration terminee.
echo Le shell de l'utilisateur "%USERNAME%" a ete remplace par Conditionnement.
echo Au prochain login de ce compte, seule l'application se lancera.
echo.
echo Pour annuler : executez le script remove-kiosk.bat sur ce compte.
echo.
pause
