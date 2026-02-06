# Architecture — BriefShot

## Vue d'ensemble

BriefShot suit une architecture en couches avec le pattern BLoC pour la gestion d'état. Chaque fonctionnalité est isolée dans son propre BLoC avec ses événements et états.

```
┌─────────────────────────────────────────────┐
│                   UI Layer                   │
│        Screens / Widgets / Navigation        │
├─────────────────────────────────────────────┤
│              State Management                │
│           BLoC (Events → States)             │
├─────────────────────────────────────────────┤
│              Data Access Layer               │
│          Repository / Services               │
├─────────────────────────────────────────────┤
│               External Services              │
│    Firebase Auth / Firestore / Storage       │
│         Google Maps API / Geolocator         │
└─────────────────────────────────────────────┘
```

## Couche UI

### Screens (écrans)

Chaque écran correspond à une page complète de l'application.

| Écran | Fichier | Description |
|-------|---------|-------------|
| Authentification | `AuthentificationScreen.dart` | Login / Inscription |
| Carte | `MapScreen.dart` | Carte interactive avec markers |
| Profil | `ProfileScreen.dart` | Profil utilisateur |
| Ajout de shot | `AddMarkerScreen.dart` | Formulaire 2 étapes |
| Paramètres | `SettingsScreen.dart` | Menu des paramètres |
| Détail paramètre | `SettingTileScreen.dart` | Page de paramètre individuel |
| Centres d'intérêt | `InterestScreen.dart` | Sélection d'intérêts |
| Messages | `MessageScreen.dart` | **Stub** — à implémenter |
| Notifications | `NotificationScreen.dart` | **Stub** — à implémenter |

### Widgets

Composants réutilisables. Chaque widget a une responsabilité unique :
- Formulaires (`SignInFormWidget`, `SignUpFormWidget`, `UpdatePasswordForm`, `UpdateEmailForm`)
- Composants shot (`AddShotStepOne`, `AddShotStepTwo`)
- Éléments UI (`TagPill`, `InterestCard`, `FilterButton`, `NavBar`)
- Popups (`AskUsername`, `AskPassword`, `LocationRequestPopup`)

### Navigation

- **Bottom navigation** (4 tabs) gérée par `NavigationBloc`
- Transitions par `AnimatedSwitcher` avec `FadeTransition`
- Navigation push classique pour Settings et sous-pages

## Couche BLoC (State Management)

Chaque feature a sa propre triade : `Bloc` + `Event` + `State`.

```
blocs/
├── authentication/
│   ├── authentication_bloc.dart     # Logique auth
│   ├── authentication_event.dart    # SignUpAsked, SignInAsked
│   └── authentication_state.dart    # Initial, Loading, Success, Error
├── navigation/
│   ├── navigation_bloc.dart         # Tab switching
│   ├── navigation_event.dart        # TabChanged
│   └── navigation_state.dart        # currentTabIndex, screens[]
├── shot/
│   ├── shot_bloc.dart               # Création de shot
│   ├── shot_event.dart              # ShotImageChangeAsked, ShotPosted
│   └── shot_state.dart              # Image, name, step tracking
└── ...                              # 15 BLoCs au total
```

### Conventions BLoC

- **Events** : verbe au passé composé (`ProfileEditionAsked`, `ShotPosted`)
- **States** : extension d'`Equatable` pour comparaison efficace
- **Bloc** : traitement des events via `on<Event>` avec `emit(newState)`

## Couche Data

### Repositories

| Repository | Responsabilité |
|------------|---------------|
| `UserRepository` | Firebase Auth (signUp, signIn, signOut, updateEmail, updatePassword) |
| `UserInfosRepository` | CRUD profil utilisateur dans Firestore |
| `InterestRepository` | Lecture des intérêts disponibles depuis Firestore |
| `PlaceRepository` | CRUD des lieux/shots dans Firestore |
| `FirebaseStorageRepository` | Upload/download images (avatar, cover, shots) |

### Services

| Service | Responsabilité |
|---------|---------------|
| `MapService` | Opérations Google Maps API |
| `AutoCompleteService` | Autocomplétion d'adresses |
| `NetworkUtils` | Utilitaires réseau |

### Entities (modèles)

```dart
// UserInfos — Profil utilisateur
class UserInfos extends Equatable {
  String avatar, cover, username;
  List<String> interestedInTags, favoritePlaces, posts;
}

// Interest — Catégorie d'intérêt
class Interest extends Equatable {
  String label, image;
}
```

## Firebase — Structure Firestore

```
firestore/
├── users/
│   └── {uid}/
│       ├── avatar: string (URL)
│       ├── cover: string (URL)
│       ├── username: string
│       ├── interestedInTags: string[]
│       ├── favoritePlaces: string[]
│       └── posts: string[]
├── interests/
│   └── {id}/
│       ├── label: string
│       └── image: string (URL)
└── places/
    └── {id}/
        ├── name: string
        ├── image: string (URL)
        └── coordinates: geopoint
```

## Décisions d'architecture (ADR)

### ADR-001 : BLoC plutôt que Provider/Riverpod

**Contexte :** Choix du state management pour une app à multiples features indépendantes.
**Décision :** BLoC pour sa séparation stricte events/states et sa testabilité.
**Conséquence :** Chaque feature a son propre BLoC. Plus de boilerplate mais meilleure maintenabilité.

### ADR-002 : Firebase comme backend

**Contexte :** Besoin d'un backend rapide à mettre en place avec auth, base de données temps réel et stockage de fichiers.
**Décision :** Firebase (Auth + Firestore + Storage).
**Conséquence :** Pas de backend custom à maintenir. Limité par les règles Firestore pour les requêtes complexes.

### ADR-003 : Repository pattern

**Contexte :** Découplage entre BLoCs et Firebase SDK.
**Décision :** Couche Repository entre les BLoCs et Firebase.
**Conséquence :** Les BLoCs ne connaissent pas Firebase directement. Facilite les tests et un éventuel changement de backend.

### ADR-004 : Google Maps Flutter

**Contexte :** Feature centrale de l'app — affichage de lieux sur une carte.
**Décision :** `google_maps_flutter` + `geolocator` pour la géolocalisation.
**Conséquence :** Dépendance à une clé API Google. Nécessite configuration native Android/iOS.

## Diagramme de flux — Création d'un shot

```
┌──────────┐    ┌──────────────┐    ┌──────────────┐
│  User    │───▶│ AddShotStep1 │───▶│ AddShotStep2 │
│  tap +   │    │ Photo + Nom  │    │ Localisation │
└──────────┘    └──────┬───────┘    └──────┬───────┘
                       │                    │
                       ▼                    ▼
                ┌──────────────┐    ┌──────────────┐
                │   ShotBloc   │───▶│   ShotBloc   │
                │ ImageChanged │    │  ShotPosted  │
                └──────┬───────┘    └──────┬───────┘
                       │                    │
                       ▼                    ▼
                ┌──────────────┐    ┌──────────────┐
                │   Storage    │    │  Firestore   │
                │ Upload image │    │  Save place  │
                └──────────────┘    └──────────────┘
```

## Points d'attention

1. **Pas de tests** — Aucun test unitaire ou widget test n'existe actuellement
2. **Markers hardcodés** — La carte utilise des coordonnées en dur (Paris, Lille, Marseille)
3. **Pas de gestion offline** — Aucune stratégie de cache ou mode hors-ligne
4. **Pas de pagination** — Les listes chargent toutes les données d'un coup
5. **Sécurité Firestore** — Les règles de sécurité doivent être auditées
