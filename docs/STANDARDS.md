# Standards & Conventions — BriefShot

## Langage & Framework

- **Dart** avec Flutter
- **Null safety** activé
- **Analysis options** : `flutter_lints` (règles standard Flutter)

## Nommage

### Fichiers

| Type | Convention | Exemple |
|------|-----------|---------|
| Screens | PascalCase + `Screen` | `MapScreen.dart` |
| Widgets | PascalCase | `NavBar.dart`, `TagPill.dart` |
| BLoC | snake_case + suffixe | `authentication_bloc.dart`, `authentication_event.dart`, `authentication_state.dart` |
| Repository | PascalCase + `Repository` | `UserRepository.dart` |
| Service | PascalCase + `Service` | `MapService.dart` |
| Entity | PascalCase | `UserInfos.dart` |

### Dart

| Type | Convention | Exemple |
|------|-----------|---------|
| Classes | PascalCase | `ProfileBloc`, `UserInfos` |
| Variables | camelCase | `currentTabIndex`, `favoritePlaces` |
| Constantes | camelCase | `primaryDark` |
| Events BLoC | PascalCase, verbe passé | `ProfileEditionAsked`, `ShotPosted` |
| States BLoC | PascalCase, descriptif | `AuthenticationInitial`, `AuthenticationLoading` |
| Enums | PascalCase | `AuthenticationStatus` |

## Architecture

### Règles strictes

1. **Pas de logique métier dans les widgets** — Toute logique passe par un BLoC
2. **Pas d'appel Firebase direct dans les BLoCs** — Passer par un Repository
3. **Un BLoC par feature** — Pas de BLoC "fourre-tout"
4. **States Equatable** — Tous les states étendent `Equatable`
5. **Events immutables** — Tous les events sont des classes `final`

### Structure d'un BLoC

```dart
// event
abstract class FeatureEvent extends Equatable {
  const FeatureEvent();
  @override
  List<Object?> get props => [];
}

class SomeActionAsked extends FeatureEvent {}

// state
class FeatureState extends Equatable {
  final bool isLoading;
  final String? error;

  const FeatureState({this.isLoading = false, this.error});

  FeatureState copyWith({bool? isLoading, String? error}) {
    return FeatureState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [isLoading, error];
}

// bloc
class FeatureBloc extends Bloc<FeatureEvent, FeatureState> {
  final FeatureRepository _repository;

  FeatureBloc(this._repository) : super(const FeatureState()) {
    on<SomeActionAsked>(_onSomeAction);
  }

  Future<void> _onSomeAction(
    SomeActionAsked event,
    Emitter<FeatureState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    try {
      await _repository.doSomething();
      emit(state.copyWith(isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }
}
```

### Structure d'un Repository

```dart
class FeatureRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Feature>> getAll() async {
    final snapshot = await _firestore.collection('features').get();
    return snapshot.docs.map((doc) => Feature.fromSnapshot(doc)).toList();
  }

  Future<void> create(Feature feature) async {
    await _firestore.collection('features').add(feature.toMap());
  }
}
```

### Structure d'une Entity

```dart
class Feature extends Equatable {
  final String id;
  final String name;

  const Feature({required this.id, required this.name});

  factory Feature.fromSnapshot(DocumentSnapshot doc) {
    return Feature(id: doc.id, name: doc['name']);
  }

  factory Feature.fromMap(Map<String, dynamic> map) {
    return Feature(id: map['id'], name: map['name']);
  }

  Map<String, dynamic> toMap() => {'name': name};

  @override
  List<Object?> get props => [id, name];
}
```

## UI / Design

### Couleurs

| Nom | Hex | Utilisation |
|-----|-----|-------------|
| Primary Dark | `0xFF0B1012` | Background principal |
| Teal Accent | — | Boutons, liens actifs |
| Orange Accent | — | Highlights, CTAs |
| White | `0xFFFFFFFF` | Texte principal |
| Grey | — | Texte secondaire |

### Typographie

- **Titres** : `DrukWideWeb` (font custom), 24px
- **Body** : Font système Flutter, 14-16px
- **Labels** : Font système, 12px, uppercase pour les actions

### Composants UI

- Coins arrondis : 12-16px de rayon
- Padding standard : 16px horizontal, 12px vertical
- Touch targets minimum : 44x44px (accessibilité)
- Icônes : SVG via `flutter_svg`, stockées dans `assets/icons/`

### Navigation

- Bottom bar fixe avec 4 tabs
- Transitions `FadeTransition` de 300ms entre tabs
- `Navigator.push` pour les sous-pages (Settings, etc.)

## Gestion d'erreurs

### Pattern standard

```dart
try {
  final result = await repository.doSomething();
  emit(state.copyWith(data: result, isLoading: false));
} on FirebaseAuthException catch (e) {
  emit(state.copyWith(error: _mapAuthError(e.code), isLoading: false));
} catch (e) {
  emit(state.copyWith(error: 'Une erreur est survenue', isLoading: false));
}
```

### Codes d'erreur Firebase Auth

| Code | Message UI |
|------|-----------|
| `weak-password` | Le mot de passe est trop faible |
| `email-already-in-use` | Cette adresse email est déjà utilisée |
| `invalid-email` | Adresse email invalide |
| `user-not-found` | Aucun compte trouvé |
| `wrong-password` | Mot de passe incorrect |

## Git

### Branches

- `main` — Production stable
- `develop` — Développement actif
- `feature/TICKET-{ID}-description` — Feature branches
- `fix/TICKET-{ID}-description` — Bug fix branches

### Commits

Format : `type(scope): description`

Types : `feat`, `fix`, `refactor`, `docs`, `style`, `test`, `chore`

Exemples :
```
feat(auth): add email/password sign up flow
fix(map): resolve hardcoded marker positions
refactor(profile): extract avatar upload to repository
docs(readme): update installation instructions
test(auth): add unit tests for AuthenticationBloc
```

### Pull Requests

- Titre : même format que les commits
- Description : résumé + lien vers le ticket
- Review obligatoire avant merge
- CI verte obligatoire (flutter analyze + tests)

## Tests (à mettre en place)

### Structure cible

```
test/
├── blocs/           # Tests unitaires BLoC
├── repository/      # Tests unitaires Repository (mocks Firebase)
├── widgets/         # Widget tests
├── screens/         # Integration tests
└── helpers/         # Mocks et fixtures partagés
```

### Conventions de test

- Un fichier de test par fichier source : `authentication_bloc_test.dart`
- Nomenclature : `group('FeatureBloc', () { test('should ...', () { }); });`
- Mocks avec `mocktail` ou `mockito`
- Couverture cible : 80% minimum sur les BLoCs et Repositories
