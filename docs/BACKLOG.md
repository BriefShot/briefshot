# Backlog — BriefShot

## Board Summary

```
BACKLOG: 0 | TODO: 24 | IN_PROGRESS: 0 | IN_REVIEW: 0 | QA: 0 | DONE: 0
```

---

## Sprint 1 — Fondations & Qualité

### TICKET-001 : Écrire les tests unitaires pour AuthenticationBloc

```
Status: TODO
Assignee: backend
Priority: P0 (critical)
Depends on: —
Blocks: TICKET-010
Story points: 5
Description:
  Mettre en place l'infrastructure de test et écrire les tests unitaires
  pour AuthenticationBloc (sign up, sign in, erreurs).
Acceptance criteria:
  - [ ] Structure test/ créée avec helpers/mocks
  - [ ] Tests pour SignUpAsked (success + toutes les erreurs Firebase)
  - [ ] Tests pour SignInAsked (success + toutes les erreurs Firebase)
  - [ ] Mocks pour UserRepository
  - [ ] Couverture > 90% sur AuthenticationBloc
Review checklist:
  - [ ] techlead approved
  - [ ] qa validated
  - [ ] product accepted
```

### TICKET-002 : Écrire les tests unitaires pour ProfileBloc et UserInfosBloc

```
Status: TODO
Assignee: backend
Priority: P0 (critical)
Depends on: TICKET-001
Blocks: TICKET-010
Story points: 5
Description:
  Tests unitaires pour ProfileBloc (edition mode, cancel) et
  UserInfosBloc (load, update, stream).
Acceptance criteria:
  - [ ] Tests pour ProfileEditionAsked / ProfileEditionCancelled
  - [ ] Tests pour LoadUserInfos (success + error)
  - [ ] Tests pour mise à jour du profil
  - [ ] Mocks pour UserInfosRepository et FirebaseStorageRepository
  - [ ] Couverture > 90% sur les deux BLoCs
Review checklist:
  - [ ] techlead approved
  - [ ] qa validated
  - [ ] product accepted
```

### TICKET-003 : Écrire les tests unitaires pour ShotBloc

```
Status: TODO
Assignee: backend
Priority: P1 (high)
Depends on: TICKET-001
Blocks: TICKET-010
Story points: 3
Description:
  Tests unitaires pour le flow de création de shot (image, nom, localisation, post).
Acceptance criteria:
  - [ ] Tests pour ShotImageChangeAsked
  - [ ] Tests pour ShotNameChanged
  - [ ] Tests pour ShotPosted (success + error)
  - [ ] Mocks pour PlaceRepository et FirebaseStorageRepository
Review checklist:
  - [ ] techlead approved
  - [ ] qa validated
  - [ ] product accepted
```

### TICKET-004 : Configurer le CI/CD avec tests et analyse

```
Status: TODO
Assignee: backend
Priority: P0 (critical)
Depends on: TICKET-001
Blocks: —
Story points: 3
Description:
  Mettre à jour le workflow GitHub Actions pour inclure flutter analyze,
  flutter test, et le build APK. Corriger le secret mal nommé (.env.development
  utilise SUPABASE_URL au lieu de MAPS_API_KEY).
Acceptance criteria:
  - [ ] CI exécute flutter analyze
  - [ ] CI exécute flutter test
  - [ ] CI build APK
  - [ ] Secret .env.development corrigé (MAPS_API_KEY, pas SUPABASE_URL)
  - [ ] CI passe sur la branche main
Review checklist:
  - [ ] techlead approved
  - [ ] qa validated
  - [ ] product accepted
```

### TICKET-005 : Créer le fichier .env.example

```
Status: TODO
Assignee: backend
Priority: P2 (medium)
Depends on: —
Blocks: —
Story points: 1
Description:
  Créer un .env.example documentant les variables d'environnement nécessaires,
  pour faciliter l'onboarding développeur.
Acceptance criteria:
  - [ ] .env.example créé avec toutes les variables nécessaires
  - [ ] Commentaires explicatifs pour chaque variable
  - [ ] README mis à jour pour référencer .env.example
Review checklist:
  - [ ] techlead approved
  - [ ] qa validated
  - [ ] product accepted
```

---

## Sprint 2 — Carte dynamique & Shots

### TICKET-006 : Remplacer les markers hardcodés par des données Firestore

```
Status: TODO
Assignee: backend
Priority: P0 (critical)
Depends on: —
Blocks: TICKET-007
Story points: 5
Description:
  La carte affiche actuellement 3 markers en dur (Paris, Lille, Marseille).
  Charger les shots depuis Firestore et les afficher dynamiquement.
Acceptance criteria:
  - [ ] PlaceRepository expose un Stream<List<Place>> ou Future<List<Place>>
  - [ ] MapBloc écoute les places et met à jour les markers
  - [ ] Markers affichés correspondent aux shots en base
  - [ ] Markers apparaissent avec le bon icône
  - [ ] Suppression des coordonnées hardcodées
Review checklist:
  - [ ] techlead approved
  - [ ] qa validated
  - [ ] product accepted
```

### TICKET-007 : Ajouter le détail d'un shot au tap sur un marker

```
Status: TODO
Assignee: frontend
Priority: P1 (high)
Depends on: TICKET-006, TICKET-008
Blocks: —
Story points: 5
Description:
  Au tap sur un marker de la carte, afficher une bottom sheet avec les
  détails du shot (photo, nom, auteur, distance).
Acceptance criteria:
  - [ ] Tap sur marker → bottom sheet avec détails
  - [ ] Photo du shot affichée
  - [ ] Nom du lieu et auteur affichés
  - [ ] Distance depuis la position actuelle calculée
  - [ ] Bouton pour fermer la bottom sheet
  - [ ] Animation d'ouverture fluide
Review checklist:
  - [ ] techlead approved
  - [ ] qa validated
  - [ ] product accepted
```

### TICKET-008 : Design — Spécification de la bottom sheet détail shot

```
Status: TODO
Assignee: designer
Priority: P0 (critical)
Depends on: —
Blocks: TICKET-007
Story points: 3
Description:
  Concevoir la bottom sheet de détail d'un shot qui s'affiche au tap sur
  un marker de la carte.
Acceptance criteria:
  - [ ] Layout structure documentée
  - [ ] Tokens de design : couleurs, typographie, spacing
  - [ ] États : loading, loaded, error
  - [ ] Specs d'animation d'ouverture/fermeture
  - [ ] Fichier livré dans /docs/design/shot-detail-sheet.md
Review checklist:
  - [ ] techlead approved
  - [ ] qa validated
  - [ ] product accepted
```

### TICKET-009 : Enrichir l'entity Place avec coordonnées et auteur

```
Status: TODO
Assignee: backend
Priority: P0 (critical)
Depends on: —
Blocks: TICKET-006
Story points: 3
Description:
  Créer une entity Place complète avec : id, name, image, coordinates
  (lat/lng), authorId, createdAt. Mettre à jour PlaceRepository.
Acceptance criteria:
  - [ ] Entity Place avec tous les champs
  - [ ] fromSnapshot et toMap implémentés
  - [ ] PlaceRepository mis à jour pour CRUD complet
  - [ ] Equatable implémenté
Review checklist:
  - [ ] techlead approved
  - [ ] qa validated
  - [ ] product accepted
```

---

## Sprint 3 — Messagerie

### TICKET-010 : Design — Spécification écran liste de conversations

```
Status: TODO
Assignee: designer
Priority: P1 (high)
Depends on: —
Blocks: TICKET-012
Story points: 3
Description:
  Concevoir l'écran liste des conversations (inbox).
Acceptance criteria:
  - [ ] Layout : liste de conversations avec avatar, dernier message, timestamp
  - [ ] États : vide, chargement, liste, erreur
  - [ ] Indicateur de messages non lus
  - [ ] Recherche de conversations
  - [ ] Fichier livré dans /docs/design/message-list.md
Review checklist:
  - [ ] techlead approved
  - [ ] qa validated
  - [ ] product accepted
```

### TICKET-011 : Design — Spécification écran conversation (chat)

```
Status: TODO
Assignee: designer
Priority: P1 (high)
Depends on: —
Blocks: TICKET-013
Story points: 3
Description:
  Concevoir l'écran de conversation individuelle (chat).
Acceptance criteria:
  - [ ] Layout : bulles de messages, input, header
  - [ ] Tokens de design pour les bulles (envoyé vs reçu)
  - [ ] États : vide, chargement, messages, erreur
  - [ ] Indicateur de saisie (typing)
  - [ ] Support photo dans les messages
  - [ ] Fichier livré dans /docs/design/chat-screen.md
Review checklist:
  - [ ] techlead approved
  - [ ] qa validated
  - [ ] product accepted
```

### TICKET-012 : Implémenter l'écran liste de conversations

```
Status: TODO
Assignee: frontend
Priority: P1 (high)
Depends on: TICKET-010, TICKET-014
Blocks: TICKET-013
Story points: 8
Description:
  Remplacer le stub MessageScreen par l'écran liste de conversations.
Acceptance criteria:
  - [ ] Liste des conversations avec avatar, nom, dernier message, timestamp
  - [ ] Badge messages non lus
  - [ ] Tri par dernier message (plus récent en haut)
  - [ ] État vide avec message d'encouragement
  - [ ] État loading avec skeleton
  - [ ] Tap → navigation vers l'écran de chat
Review checklist:
  - [ ] techlead approved
  - [ ] qa validated
  - [ ] product accepted
```

### TICKET-013 : Implémenter l'écran de chat

```
Status: TODO
Assignee: frontend
Priority: P1 (high)
Depends on: TICKET-011, TICKET-014
Blocks: —
Story points: 8
Description:
  Implémenter l'écran de conversation en temps réel.
Acceptance criteria:
  - [ ] Affichage des messages en bulles (envoyé/reçu)
  - [ ] Input de saisie avec bouton d'envoi
  - [ ] Scroll automatique vers le bas à chaque nouveau message
  - [ ] Chargement des messages historiques (pagination)
  - [ ] Indicateur de messages non lus mis à jour
  - [ ] Header avec nom et avatar du contact
Review checklist:
  - [ ] techlead approved
  - [ ] qa validated
  - [ ] product accepted
```

### TICKET-014 : Backend — Structure Firestore et BLoC messagerie

```
Status: TODO
Assignee: backend
Priority: P1 (high)
Depends on: —
Blocks: TICKET-012, TICKET-013
Story points: 8
Description:
  Créer la structure Firestore pour la messagerie, les entities, le
  repository et le BLoC.
Acceptance criteria:
  - [ ] Collection conversations/{id} avec participants[], lastMessage, updatedAt
  - [ ] Sous-collection conversations/{id}/messages/{id} avec senderId, text, createdAt
  - [ ] Entity Conversation et Message créées
  - [ ] ConversationRepository avec streams temps réel
  - [ ] MessageBloc (load, send, listen)
  - [ ] ConversationListBloc (list, listen for new messages)
Review checklist:
  - [ ] techlead approved
  - [ ] qa validated
  - [ ] product accepted
```

---

## Sprint 4 — Notifications

### TICKET-015 : Design — Spécification écran notifications

```
Status: TODO
Assignee: designer
Priority: P1 (high)
Depends on: —
Blocks: TICKET-017
Story points: 3
Description:
  Concevoir l'écran de notifications.
Acceptance criteria:
  - [ ] Layout : liste de notifications avec icône, texte, timestamp
  - [ ] Types : nouveau message, nouveau follower, like sur shot, système
  - [ ] États : vide, chargement, liste, erreur
  - [ ] Action au tap selon le type de notification
  - [ ] Marquage lu/non lu
  - [ ] Fichier livré dans /docs/design/notifications.md
Review checklist:
  - [ ] techlead approved
  - [ ] qa validated
  - [ ] product accepted
```

### TICKET-016 : Backend — Structure Firestore et BLoC notifications

```
Status: TODO
Assignee: backend
Priority: P1 (high)
Depends on: —
Blocks: TICKET-017
Story points: 5
Description:
  Créer la structure Firestore pour les notifications, les entities,
  le repository et le BLoC.
Acceptance criteria:
  - [ ] Collection users/{uid}/notifications/{id}
  - [ ] Entity Notification (type, title, body, data, read, createdAt)
  - [ ] NotificationRepository avec stream temps réel
  - [ ] NotificationBloc (load, markRead, markAllRead)
  - [ ] Badge count sur le tab notifications dans NavBar
Review checklist:
  - [ ] techlead approved
  - [ ] qa validated
  - [ ] product accepted
```

### TICKET-017 : Implémenter l'écran notifications

```
Status: TODO
Assignee: frontend
Priority: P1 (high)
Depends on: TICKET-015, TICKET-016
Blocks: —
Story points: 5
Description:
  Remplacer le stub NotificationScreen par l'écran complet.
Acceptance criteria:
  - [ ] Liste des notifications par type
  - [ ] Visuel lu/non lu
  - [ ] Tap → navigation vers le contenu lié
  - [ ] Swipe pour marquer lu
  - [ ] Bouton "tout marquer comme lu"
  - [ ] État vide avec message
Review checklist:
  - [ ] techlead approved
  - [ ] qa validated
  - [ ] product accepted
```

---

## Sprint 5 — Social

### TICKET-018 : Backend — Système de follow/unfollow

```
Status: TODO
Assignee: backend
Priority: P2 (medium)
Depends on: —
Blocks: TICKET-019, TICKET-020
Story points: 5
Description:
  Implémenter le système de follow/unfollow dans Firestore.
Acceptance criteria:
  - [ ] Collection users/{uid}/following/{targetUid}
  - [ ] Collection users/{uid}/followers/{followerUid}
  - [ ] FollowRepository (follow, unfollow, isFollowing, getFollowers, getFollowing)
  - [ ] FollowBloc
  - [ ] Compteurs followers/following sur le profil
Review checklist:
  - [ ] techlead approved
  - [ ] qa validated
  - [ ] product accepted
```

### TICKET-019 : Backend — Système de likes sur les shots

```
Status: TODO
Assignee: backend
Priority: P2 (medium)
Depends on: TICKET-009
Blocks: TICKET-020
Story points: 3
Description:
  Ajouter la possibilité de liker/unliker un shot.
Acceptance criteria:
  - [ ] Sous-collection places/{id}/likes/{uid}
  - [ ] Compteur de likes sur l'entity Place
  - [ ] LikeRepository (like, unlike, isLiked, getLikeCount)
  - [ ] Intégration dans ShotBloc ou nouveau LikeBloc
Review checklist:
  - [ ] techlead approved
  - [ ] qa validated
  - [ ] product accepted
```

### TICKET-020 : Feed de découverte — Shots à proximité

```
Status: TODO
Assignee: frontend
Priority: P2 (medium)
Depends on: TICKET-006, TICKET-018, TICKET-019
Blocks: —
Story points: 8
Description:
  Créer un feed de découverte montrant les shots à proximité de
  l'utilisateur, avec possibilité de liker et voir le profil de l'auteur.
Acceptance criteria:
  - [ ] Liste scrollable de shots triés par proximité
  - [ ] Carte miniature de chaque shot
  - [ ] Photo, nom du lieu, auteur, distance, nombre de likes
  - [ ] Bouton like
  - [ ] Tap auteur → profil
  - [ ] Pull-to-refresh
Review checklist:
  - [ ] techlead approved
  - [ ] qa validated
  - [ ] product accepted
```

---

## Sprint 6 — Settings & Sécurité

### TICKET-021 : Implémenter la suppression de compte

```
Status: TODO
Assignee: backend
Priority: P1 (high)
Depends on: —
Blocks: —
Story points: 5
Description:
  Implémenter la fonctionnalité de suppression de compte (actuellement
  un stub vide dans SettingsScreen).
Acceptance criteria:
  - [ ] Dialog de confirmation avec re-authentification
  - [ ] Suppression des données Firestore (profil, shots, conversations)
  - [ ] Suppression des fichiers Storage (avatar, cover, images shots)
  - [ ] Suppression du compte Firebase Auth
  - [ ] Redirection vers l'écran d'authentification
  - [ ] Gestion des erreurs
Review checklist:
  - [ ] techlead approved
  - [ ] qa validated
  - [ ] product accepted
```

### TICKET-022 : Implémenter "Nous contacter"

```
Status: TODO
Assignee: frontend
Priority: P3 (low)
Depends on: —
Blocks: —
Story points: 2
Description:
  Implémenter la fonctionnalité "Nous contacter" dans les paramètres.
Acceptance criteria:
  - [ ] Ouverture d'un email pré-rempli (mailto:) ou formulaire in-app
  - [ ] Sujet et corps pré-remplis avec infos device/version
Review checklist:
  - [ ] techlead approved
  - [ ] qa validated
  - [ ] product accepted
```

### TICKET-023 : Auditer et configurer les règles de sécurité Firestore

```
Status: TODO
Assignee: backend
Priority: P0 (critical)
Depends on: —
Blocks: —
Story points: 5
Description:
  Écrire des règles de sécurité Firestore strictes pour protéger
  les données utilisateur.
Acceptance criteria:
  - [ ] Un utilisateur ne peut lire/écrire que son propre profil
  - [ ] Les shots sont lisibles par tous, modifiables uniquement par l'auteur
  - [ ] Les conversations sont lisibles uniquement par les participants
  - [ ] Les messages ne peuvent être envoyés que par les participants
  - [ ] Les notifications sont privées à l'utilisateur
  - [ ] Règles documentées dans /docs/SECURITY.md
Review checklist:
  - [ ] techlead approved
  - [ ] qa validated
  - [ ] product accepted
```

### TICKET-024 : Ajouter la gestion du mode offline

```
Status: TODO
Assignee: backend
Priority: P2 (medium)
Depends on: —
Blocks: —
Story points: 5
Description:
  Activer la persistance Firestore et gérer les états offline/online.
Acceptance criteria:
  - [ ] Firestore persistence activée
  - [ ] Indicateur visuel quand l'app est hors-ligne
  - [ ] Les opérations d'écriture sont mises en queue
  - [ ] Sync automatique au retour en ligne
  - [ ] Les données en cache sont affichées quand offline
Review checklist:
  - [ ] techlead approved
  - [ ] qa validated
  - [ ] product accepted
```

---

## Résumé des priorités

| Priorité | Tickets | Focus |
|----------|---------|-------|
| **P0** | 001, 002, 004, 006, 008, 009, 023 | Tests, CI, carte dynamique, sécurité |
| **P1** | 003, 010-017, 021 | Messagerie, notifications, suppression compte |
| **P2** | 005, 018-020, 024 | Social, feed, offline |
| **P3** | 022 | Contact |

## Dépendances clés

```
TICKET-001 ──▶ TICKET-002, TICKET-003, TICKET-004
TICKET-009 ──▶ TICKET-006 ──▶ TICKET-007
TICKET-008 ──▶ TICKET-007
TICKET-010 ──▶ TICKET-012
TICKET-011 ──▶ TICKET-013
TICKET-014 ──▶ TICKET-012, TICKET-013
TICKET-015 ──▶ TICKET-017
TICKET-016 ──▶ TICKET-017
TICKET-018 ──▶ TICKET-020
TICKET-019 ──▶ TICKET-020
```
