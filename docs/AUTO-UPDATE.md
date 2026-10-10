# Auto-Update via GitHub Releases (repo public)

## Fonctionnement

1. Un tag `vX.Y.Z` est pousse sur le repo source `Agriplus-IO/app-packing-line-windows`
2. GitHub Actions build l'application pour Windows et macOS
3. Les artefacts (.exe, .dmg, .zip) + fichiers de metadata (latest.yml, latest-mac.yml)
   sont publies en GitHub Release sur ce repo (`app-packing-line-windows-releases`)
4. L'app verifie au demarrage, puis toutes les heures, si une nouvelle version est disponible
5. Si oui, elle telecharge en arriere-plan et propose de redemarrer ;
   sinon la mise a jour s'installe a la prochaine fermeture

Le repo de releases est public : l'application n'a besoin d'aucun token pour se mettre a jour.

## Secrets GitHub a configurer

Dans le repo source `app-packing-line-windows` → Settings → Secrets and variables → Actions :

| Secret | Description | Obligatoire |
|--------|-------------|-------------|
| `PAT_GITHUB` | Token GitHub avec ecriture sur `app-packing-line-windows-releases` (creation et publication des releases) | Oui |
| `FONTAWESOME_TOKEN` | Token npm pour @fortawesome/fontawesome-pro | Oui |
| `MAC_CERT_P12` | Certificat Apple (base64 du .p12) pour signer le DMG | macOS uniquement |
| `MAC_CERT_PASSWORD` | Mot de passe du certificat .p12 | macOS uniquement |

## Comment publier une release

```bash
# 1. Mettre a jour la version dans package.json (source unique de la version)
npm version 2.8.19 --no-git-tag-version

# 2. Commit
git add package.json package-lock.json
git commit -m "chore: bump version 2.8.19"

# 3. Tag et push
git tag v2.8.19
git push origin main --tags
```

GitHub Actions se declenche automatiquement et publie la release.

Le tag doit correspondre a la version de `package.json` : c'est elle qui est inscrite
dans `latest.yml` et comparee par l'application.

## Journal des mises a jour

Depuis la 2.8.23, l'application ecrit un journal des verifications, telechargements et erreurs :
- Windows : `%APPDATA%\Conditionnement\logs\updater.log`
- macOS : `~/Library/Application Support/Conditionnement/logs/updater.log`
- Acces direct : menu **Aide > Afficher le journal des mises a jour**

## Verifier que l'auto-update fonctionne

L'app log les evenements de mise a jour dans la console Electron (prefixe `[Main][Updater]`).
Pour tester :
1. Builder et installer une version (ex: v2.8.18)
2. Publier une release v2.8.19
3. Lancer l'app v2.8.18 → elle detecte v2.8.19, telecharge, et propose le redemarrage

L'auto-update ne tourne que dans l'application installee (pas en developpement).
