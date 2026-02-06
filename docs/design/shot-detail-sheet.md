# Shot Detail Bottom Sheet — Spec Design

**Ticket :** TICKET-008
**Status :** TODO
**Assignee :** designer

## Contexte

Bottom sheet qui s'affiche quand l'utilisateur tape sur un marker de shot sur la carte.

## Layout

```
┌─────────────────────────────────┐
│          ── handle ──           │  ← drag handle (40x4px, radius-full)
│                                 │
│  ┌───────────────────────────┐  │
│  │                           │  │
│  │      Photo du shot        │  │  ← 16:9 ratio, radius-lg
│  │      (full width)         │  │
│  │                           │  │
│  └───────────────────────────┘  │
│                                 │
│  Nom du lieu                    │  ← h3, text-primary
│  📍 1.2 km • Ajouté par @user  │  ← body-sm, text-secondary
│                                 │
│  ┌─────────┐  ┌─────────────┐  │
│  │  ❤️ 42  │  │  Voir plus  │  │  ← boutons action
│  └─────────┘  └─────────────┘  │
│                                 │
└─────────────────────────────────┘
```

## Tokens

- Background : `bg-secondary`
- Padding : `space-md` (16px) horizontal, `space-sm` (8px) top
- Rayon : `radius-xl` (24px) top-left et top-right
- Shadow : `shadow-lg`
- Hauteur max : 60% de l'écran

## Composants

### Drag Handle
- Largeur : 40px, hauteur : 4px
- Couleur : `text-muted`
- Rayon : `radius-full`
- Margin top : `space-sm`

### Photo
- Ratio : 16:9
- Rayon : `radius-lg`
- Margin : `space-md`
- Placeholder : skeleton animé pendant le chargement

### Infos
- Nom : `h3`, `text-primary`
- Distance + auteur : `body-sm`, `text-secondary`
- Icône localisation : inline, couleur `accent-teal`

### Boutons d'action
- Like : icône coeur + compteur, toggle filled/outlined
- Voir plus : bouton secondaire, ouvre le détail complet
- Hauteur : 40px, rayon : `radius-md`

## États

### Loading
- Skeleton animé sur la photo (rectangle pulsant)
- Skeleton sur le texte (2 lignes)

### Loaded
- Layout complet comme décrit ci-dessus

### Error
- Message "Impossible de charger ce shot"
- Bouton "Réessayer"

## Animation

- Ouverture : slide up de 400ms, `easing-spring`
- Fermeture : slide down de 300ms, `easing-default`
- Draggable : suit le doigt, snap vers ouvert ou fermé à 50%
