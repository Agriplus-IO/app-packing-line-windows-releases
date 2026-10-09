# Mode kiosque Windows 11

Guide de configuration pour deployer Conditionnement en mode kiosque sur un poste Windows 11.

---

## Principe

L'application Electron remplace l'explorateur Windows (`explorer.exe`) pour un compte utilisateur dedie.
Au demarrage du PC :
1. Connexion automatique au compte kiosque
2. L'application se lance en plein ecran (pas de bureau, pas de barre des taches)
3. Si l'application crash, elle est relancee automatiquement (script boucle)

---

## Prerequis

- Windows 11
- Conditionnement installe **depuis le compte kiosque** (installation par utilisateur) :
  `%LOCALAPPDATA%\Programs\Conditionnement\Conditionnement.exe`
- Un compte administrateur pour la configuration

---

## Etapes

### 1. Creer un compte local "kiosque"

```powershell
# En tant qu'administrateur
net user kiosque /add
# Optionnel : definir un mot de passe
net user kiosque MonMotDePasse123
```

### 2. Configurer le remplacement du shell

Executer le script `scripts/setup-kiosk.bat` **connecte sur le compte kiosque**, sans elevation
(la cle est celle de l'utilisateur courant, HKCU),
ou manuellement :

**Registry** (pour le compte kiosque uniquement) :
```
HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon
Shell = "%LOCALAPPDATA%\Programs\Conditionnement\kiosk-loop.bat"  (chemin developpe du compte kiosque)
```

Le script `kiosk-loop.bat` relance l'application en boucle si elle se ferme ou crash.

### 3. Configurer l'auto-login (optionnel)

Executer le script `scripts/setup-autologin.bat` **en tant qu'administrateur**,
ou manuellement :

**Registry** :
```
HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon
AutoAdminLogon = 1
DefaultUserName = kiosque
DefaultPassword = MonMotDePasse123
```

Note : si le compte n'a pas de mot de passe, laisser `DefaultPassword` vide.

---

## Securite

| Action utilisateur | Resultat |
|---|---|
| Alt+F4 / Fichier > Quitter | Ferme l'app (relancee par kiosk-loop.bat apres 2 s) |
| Alt+Tab | Pas de taskbar, rien a switcher |
| Ctrl+Alt+Del | Menu Windows minimal, pas d'explorateur |
| Ctrl+Alt+Del → Changer d'utilisateur | Acces au compte admin |

---

## Desinstallation du mode kiosque

1. Se connecter au compte administrateur (Ctrl+Alt+Del → Changer d'utilisateur)
2. Supprimer la cle registry `Shell` du compte kiosque :
   ```
   reg delete "HKEY_USERS\{SID_KIOSQUE}\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /v Shell /f
   ```
3. Desactiver l'auto-login :
   ```
   reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /v AutoAdminLogon /f
   reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /v DefaultPassword /f
   ```

---

## Mode plein ecran

L'application demarre toujours en plein ecran. La barre de menu est masquee ;
la touche **Alt** l'affiche (Fichier, Edition, Affichage, Aide).
