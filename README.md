# BriefShot

Application mobile de partage de lieux geolocalisés. Découvrez et partagez vos meilleurs "shots" — des endroits uniques capturés en photo et épinglés sur la carte.

## Fonctionnalités

- **Authentification** — Inscription et connexion par email/mot de passe via Firebase Auth
- **Carte interactive** — Visualisation des shots sur Google Maps avec géolocalisation
- **Création de shots** — Prise de photo + sélection d'un lieu en 2 étapes
- **Profil utilisateur** — Avatar, photo de couverture, centres d'intérêt, lieux favoris
- **Centres d'intérêt** — Sélection et gestion de tags thématiques
- **Paramètres** — Modification email/mot de passe, déconnexion

## Stack technique

| Couche | Technologie |
|--------|-------------|
| Framework | Flutter (Dart) |
| State management | BLoC (flutter_bloc) |
| Backend | Firebase (Auth, Firestore, Storage) |
| Cartographie | Google Maps Flutter + Geolocator |
| CI/CD | GitHub Actions |

## Prérequis

- Flutter SDK >= 2.19.2
- Dart SDK >= 2.19.2
- Compte Firebase configuré
- Clé API Google Maps

## Installation

```bash
# Cloner le repo
git clone https://github.com/BriefShot/briefshot.git
cd briefshot

# Installer les dépendances
flutter pub get

# Configurer les variables d'environnement
cp .env.example .env.development
# Renseigner MAPS_API_KEY dans .env.development

# Lancer en mode debug
flutter run
```

## Architecture

```
lib/
├── blocs/          # Logique métier (BLoC pattern)
├── screens/        # Écrans de l'application
├── widgets/        # Composants UI réutilisables
├── repository/     # Couche d'accès aux données Firebase
├── services/       # Services API et utilitaires
├── entities/       # Modèles de données
└── main.dart       # Point d'entrée
```

## Documentation

| Document | Description |
|----------|-------------|
| [CLAUDE.md](./CLAUDE.md) | Contexte projet pour l'IA |
| [Architecture](./docs/ARCHITECTURE.md) | Décisions d'architecture |
| [Standards](./docs/STANDARDS.md) | Conventions de code |
| [Backlog](./docs/BACKLOG.md) | Tickets et planification |
| [Workflow](./docs/WORKFLOW.md) | Processus de développement |
| [Changelog](./docs/CHANGELOG.md) | Historique des changements |
| [Design](./docs/design/) | Spécifications UI/UX |

## Statut du projet

**Version :** 0.0.0+1 (MVP en cours de développement)

Voir le [Backlog](./docs/BACKLOG.md) pour la feuille de route complète.

## Licence

Projet privé — tous droits réservés.
