# BriefShot — Project Context

## Overview

BriefShot is a location-based social mobile app built with Flutter and Firebase. Users share "shots" — geolocated places/photos — discover spots shared by others, and interact through messaging and notifications.

## Tech Stack

- **Framework:** Flutter (Dart SDK >=2.19.2 <3.0.0)
- **State Management:** BLoC pattern (flutter_bloc 8.1.2)
- **Backend:** Firebase (Auth, Firestore, Storage)
- **Maps:** Google Maps Flutter + Geolocator
- **Fonts:** DrukWideWeb (custom)
- **CI/CD:** GitHub Actions (APK build on PR)

## Architecture

```
lib/
├── main.dart                    # Entry point, Firebase init, routing
├── blocs/                       # BLoC state management (15 feature BLoCs)
│   ├── authentication/          # Sign up / Sign in
│   ├── interests/               # User interests management
│   ├── location/                # Device location tracking
│   ├── map/                     # Google Maps state
│   ├── navigation/              # Bottom tab navigation
│   ├── profile/                 # Profile editing mode
│   ├── shot/                    # Shot creation flow
│   ├── userInfos/               # User data loading
│   └── ...                      # Other feature BLoCs
├── screens/                     # Full-page screens (9 screens)
├── widgets/                     # Reusable UI components
├── repository/                  # Firebase data access layer
├── services/                    # API and utility services
├── entities/                    # Data models (UserInfos, Interest)
├── firebase/                    # Firestore collection helpers
└── utils/                       # Network utilities
```

## Data Flow

```
UI (Screens/Widgets) → BLoCs → Repository → Firebase
Real-time: Firestore Streams → BLoC → UI rebuild
Auth: FirebaseAuth → AuthenticationBloc → Navigation guard
```

## Key Patterns

- **BLoC per feature:** Each feature has its own Bloc + Events + States
- **Repository pattern:** All Firebase calls go through repository classes
- **Equatable states:** All BLoC states extend Equatable for efficient rebuilds
- **Dark theme:** Primary background `0xFF0B1012`, teal/orange accents

## Firebase Collections

- `users` — User profiles (avatar, cover, username, interestedInTags, favoritePlaces, posts)
- `interests` — Available interest categories (label, image)
- `places` — Shot locations (name, image, coordinates)

## Environment

- `.env` — Production config (MAPS_API_KEY)
- `.env.development` — Development config (MAPS_API_KEY)
- Never commit `.env` files

## Current State (v0.0.0)

### Implemented
- Authentication (email/password, Firebase Auth)
- User profile (CRUD, avatar/cover upload, interests)
- Map display (Google Maps, device location)
- Shot creation (2-step form: photo + location)
- Bottom navigation (4 tabs)
- Settings (email/password update, logout)
- Interest management (grid selection)

### Not Implemented (Stubs)
- Messaging screen (empty stub)
- Notifications screen (empty stub)
- Dynamic map markers (hardcoded test data)
- Social features (follow, like, share)
- Shot feed/discovery
- Contact us / Delete account in settings
- Unit & widget tests
- Web platform support

## Development Workflow

See `/docs/WORKFLOW.md` for the ticket-based development process.
See `/docs/BACKLOG.md` for the current backlog.
See `/docs/STANDARDS.md` for coding conventions.
See `/docs/ARCHITECTURE.md` for architecture decisions.

## Commands

```bash
# Install dependencies
flutter pub get

# Run in debug mode
flutter run

# Build APK
flutter build apk

# Run tests (when added)
flutter test

# Analyze code
flutter analyze
```
