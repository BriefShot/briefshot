# Liste de Conversations — Spec Design

**Ticket :** TICKET-010
**Status :** TODO
**Assignee :** designer

## Contexte

Écran accessible depuis le tab "Messages" de la bottom navigation. Affiche la liste des conversations de l'utilisateur.

## Layout

```
┌─────────────────────────────────┐
│  Messages              🔍       │  ← header : h2 DrukWideWeb + icône recherche
│─────────────────────────────────│
│                                 │
│  ┌──┐  Alice Martin            │  ← avatar (44px) + nom (body, bold)
│  │  │  Salut, tu connais ce... │  ← dernier message (body-sm, text-secondary)
│  └──┘                    14:32  │  ← timestamp (caption, text-muted)
│       ●                         │  ← badge non lu (accent-orange, 8px)
│─────────────────────────────────│
│                                 │
│  ┌──┐  Bob Dupont              │
│  │  │  Super le shot !          │
│  └──┘                     Hier  │
│                                 │
│─────────────────────────────────│
│  ...                            │
│                                 │
└─────────────────────────────────┘
```

## Tokens

- Background : `bg-primary`
- Séparateurs : `border` (1px)
- Padding cellule : `space-md` horizontal, `space-sm` vertical
- Avatar : 44px, `radius-full`

## Composants

### Header
- Titre : "Messages", `h2`, DrukWideWeb
- Icône recherche : tap → champ de recherche animé
- Background : `bg-primary`
- Height : 84px (cohérent avec le profil)

### Cellule de conversation
- Avatar : 44px, cercle, image de profil ou initiales
- Nom : `body`, bold, `text-primary`
- Dernier message : `body-sm`, `text-secondary`, max 1 ligne (ellipsis)
- Timestamp : `caption`, `text-muted`, aligné à droite
- Badge non lu : cercle 8px, `accent-orange`, positionné à gauche du nom
- Padding : 16px horizontal, 12px vertical
- Tap → navigation vers l'écran de chat
- Swipe gauche → archiver (optionnel v2)

### Barre de recherche (optionnelle au tap)
- Input : `bg-tertiary`, `radius-md`, placeholder "Rechercher..."
- Animation : expand de 200ms depuis l'icône

## États

### Vide
```
┌─────────────────────────────────┐
│                                 │
│         💬                      │
│                                 │
│   Pas encore de messages        │  ← h3, text-primary, centré
│   Commencez une conversation    │  ← body-sm, text-secondary
│   depuis le profil d'un         │
│   utilisateur                   │
│                                 │
└─────────────────────────────────┘
```

### Loading
- 5 skeletons de cellule (avatar cercle + 2 lignes rect pulsants)

### Error
- Message "Impossible de charger les conversations"
- Bouton "Réessayer" centré

### Liste
- Layout standard comme décrit
- Pull-to-refresh : indicateur circulaire `accent-teal`

## Animation
- Apparition des cellules : fade in + slide up séquentiel (50ms de décalage)
- Tap : effet ripple sur la cellule
- Navigation : slide left vers l'écran de chat
