# Conditionnement — Releases

Releases de l'application desktop **Conditionnement** (Agri+ IO) : suivi de la ligne de conditionnement.

## Telechargement

Telecharger la derniere version dans l'onglet **[Releases](https://github.com/Agriplus-IO/app-packing-line-windows-releases/releases)**.

| Plateforme | Fichier |
|------------|---------|
| **Windows** | `Conditionnement-Setup-X.X.X.exe` |
| **macOS** | `Conditionnement-X.X.X-arm64.dmg` |

## Installation

### Windows
1. Telecharger le `.exe`
2. Lancer l'installeur (installation silencieuse, oneClick, pour l'utilisateur courant)
3. L'application se lance automatiquement

Emplacement : `%LOCALAPPDATA%\Programs\agriplus_app_pickup-tracking-for-packaging-assembly-line\Conditionnement.exe`

### macOS
1. Telecharger le `.dmg`
2. Ouvrir le DMG
3. Glisser l'application dans le dossier Applications

## Mode kiosque (Windows)

Pour deployer l'application en mode kiosque (plein ecran, demarrage automatique) :

- **[Guide d'installation kiosque](docs/KIOSK-WINDOWS.md)**
- **[Mise a jour automatique](docs/AUTO-UPDATE.md)**

### Scripts disponibles

| Script | Description |
|--------|-------------|
| [`scripts/setup-kiosk.bat`](scripts/setup-kiosk.bat) | Configurer le mode kiosque (remplacer le shell Windows) |
| [`scripts/setup-autologin.bat`](scripts/setup-autologin.bat) | Configurer la connexion automatique au demarrage |
| [`scripts/remove-kiosk.bat`](scripts/remove-kiosk.bat) | Restaurer le bureau Windows normal |
| [`scripts/remove-autologin.bat`](scripts/remove-autologin.bat) | Desactiver la connexion automatique |
| [`scripts/kiosk-loop.bat`](scripts/kiosk-loop.bat) | Script de boucle (relance l'app si elle se ferme) |

## Mise a jour automatique

L'application verifie les mises a jour :
- Au demarrage
- Toutes les heures (pour les postes allumes en continu)
- Manuellement via le menu **Aide > Verifier les mises a jour**

La mise a jour est telechargee en arriere-plan. Une fois prete :
- **Redemarrer maintenant** — installe et relance l'application
- **Plus tard** — installe a la prochaine fermeture de l'application
