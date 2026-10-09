@echo off
:: Conditionnement - Suppression du mode kiosque
:: Restaure le shell Windows par defaut (explorer.exe) pour l'utilisateur actuel.
:: A executer SUR LE COMPTE KIOSQUE (cle HKCU).

echo ============================================
echo  Conditionnement - Suppression Kiosque
echo ============================================
echo.

:: Supprimer la cle Shell (restaure explorer.exe par defaut)
reg delete "HKCU\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /v Shell /f >nul 2>&1

echo Shell Windows restaure (explorer.exe).
echo Le bureau normal sera affiche au prochain login.
echo.
pause
