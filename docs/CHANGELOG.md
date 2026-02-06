# Changelog — BriefShot

Toutes les modifications notables du projet sont documentées ici.
Format basé sur [Keep a Changelog](https://keepachangelog.com/fr/1.0.0/).

---

## [Non publié]

### Ajouté
- Documentation complète du projet (CLAUDE.md, README, docs/)
- Backlog structuré avec 24 tickets (voir BACKLOG.md)
- Standards de code et conventions (STANDARDS.md)
- Documentation d'architecture avec ADR (ARCHITECTURE.md)
- Workflow de développement par tickets (WORKFLOW.md)
- Spécifications de design initiales (docs/design/)

---

## [0.0.0] — Date de début du projet

### Ajouté
- Authentification email/mot de passe (Firebase Auth)
- Écran de connexion et d'inscription avec gestion d'erreurs
- Profil utilisateur avec avatar et photo de couverture
- Upload d'images vers Firebase Storage
- Modification du nom d'utilisateur
- Gestion des centres d'intérêt (ajout/suppression de tags)
- Carte Google Maps avec géolocalisation
- Création de shots en 2 étapes (photo + localisation)
- Navigation par onglets (4 tabs) avec transitions
- Écran paramètres (modification email/mot de passe, déconnexion)
- CI/CD GitHub Actions (build APK)
- Thème sombre avec font custom DrukWideWeb

### Connu (à corriger)
- Markers de la carte en dur (Paris, Lille, Marseille)
- Écrans Messages et Notifications vides (stubs)
- "Nous contacter" et "Supprimer le compte" non implémentés
- Secret CI mal nommé (SUPABASE_URL au lieu de MAPS_API_KEY)
- Aucun test unitaire ou widget test
- Pas de règles de sécurité Firestore documentées
