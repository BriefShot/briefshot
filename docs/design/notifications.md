# Écran Notifications — Spec Design

**Ticket :** TICKET-015
**Status :** TODO
**Assignee :** designer

## Contexte

Écran accessible depuis le tab "Notifications" de la bottom navigation. Affiche les notifications groupées par date.

## Layout

```
┌─────────────────────────────────┐
│  Notifications     Tout lire    │  ← header + bouton "marquer tout comme lu"
│─────────────────────────────────│
│                                 │
│  Aujourd'hui                    │  ← section header (caption, text-muted)
│                                 │
│  ┌──┐ Alice a aimé votre shot  │  ← icône type + texte + timestamp
│  │❤️│ "Café du coin"           │
│  └──┘                   il y a 2h│
│  ●                              │  ← dot non lu
│─────────────────────────────────│
│  ┌──┐ Bob vous suit            │
│  │👤│ Nouveau follower         │
│  └──┘                   il y a 5h│
│─────────────────────────────────│
│                                 │
│  Hier                           │
│                                 │
│  ┌──┐ Nouveau message de Clara │
│  │💬│ "Salut, tu..."           │
│  └──┘                      14:30│
│─────────────────────────────────│
│  ...                            │
└─────────────────────────────────┘
```

## Tokens

- Background : `bg-primary`
- Cellule non lue : `bg-secondary` (légèrement surélevée)
- Cellule lue : `bg-primary` (flush avec le fond)
- Séparateurs : `border` (1px)
- Padding cellule : `space-md`

## Types de notifications

| Type | Icône | Couleur icône | Action au tap |
|------|-------|--------------|---------------|
| `like` | ❤️ | `error` | → Détail du shot |
| `follow` | 👤 | `accent-teal` | → Profil du follower |
| `message` | 💬 | `accent-orange` | → Conversation |
| `system` | ⚙️ | `text-secondary` | → Settings ou rien |
| `shot_nearby` | 📍 | `accent-teal` | → Carte centrée sur le shot |

## Composants

### Header
- Titre : "Notifications", `h2`, DrukWideWeb
- Bouton "Tout lire" : `body-sm`, `accent-teal`, aligné droite
- Tap "Tout lire" → marque toutes les notifications comme lues
- Height : 84px

### Section date
- Texte : "Aujourd'hui", "Hier", "Lundi 3 février", etc.
- Style : `overline`, `text-muted`
- Padding top : `space-lg`

### Cellule de notification
- Icône type : 40px container, `radius-md`, bg coloré (opacité 15%)
- Texte principal : `body`, `text-primary`
  - Nom d'utilisateur en bold
  - Action en regular
- Texte secondaire : `body-sm`, `text-secondary` (preview du contenu)
- Timestamp : `caption`, `text-muted`, aligné droite
- Dot non lu : 8px cercle, `accent-orange`, aligné gauche
- Swipe droite → marquer comme lu

### Badge tab navigation
- Cercle rouge avec compteur blanc
- Position : top-right de l'icône du tab
- Affiché uniquement si > 0 notifications non lues
- Max affiché : "99+"

## États

### Vide
```
┌─────────────────────────────────┐
│                                 │
│          🔔                     │
│                                 │
│   Aucune notification           │  ← h3, centré
│   Vos notifications             │  ← body-sm, text-secondary
│   apparaîtront ici              │
│                                 │
└─────────────────────────────────┘
```

### Loading
- 5 skeletons de cellule (icône cercle + 2 lignes rect)

### Error
- Message "Impossible de charger les notifications"
- Bouton "Réessayer"

### Liste
- Groupé par date
- Pull-to-refresh
- Infinite scroll pour les notifications plus anciennes

## Animations
- Apparition : fade in + slide up séquentiel (30ms décalage par cellule)
- Swipe marquer lu : slide right + fade out
- "Tout lire" : toutes les cellules non lues animent vers l'état lu (300ms)
- Nouvelle notification : slide in from top si l'écran est actif
