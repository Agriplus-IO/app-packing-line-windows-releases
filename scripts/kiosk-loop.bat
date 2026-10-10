@echo off
:: Conditionnement - Kiosk Loop
:: Ce script relance l'application en boucle si elle se ferme ou crash.
:: Utilise comme shell de remplacement pour le mode kiosque Windows.
:: L'application est installee par utilisateur : %LOCALAPPDATA% est celui du compte kiosque.

title Conditionnement - Kiosk

set APP_PATH="%LOCALAPPDATA%\Programs\agriplus_app_pickup-tracking-for-packaging-assembly-line\Conditionnement.exe"

:loop
echo [%date% %time%] Demarrage de Conditionnement...
start /wait "" %APP_PATH%
echo [%date% %time%] Application fermee. Redemarrage dans 2 secondes...
timeout /t 2 /nobreak >nul
goto loop
