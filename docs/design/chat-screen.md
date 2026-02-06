# Écran de Chat — Spec Design

**Ticket :** TICKET-011
**Status :** TODO
**Assignee :** designer

## Contexte

Écran de conversation individuelle en temps réel entre deux utilisateurs.

## Layout

```
┌─────────────────────────────────┐
│  ←  ┌──┐ Alice Martin    •     │  ← back + avatar (32px) + nom + online status
│     └──┘                        │
│─────────────────────────────────│
│                                 │
│              Aujourd'hui        │  ← date separator (caption, text-muted)
│                                 │
│         ┌───────────────────┐   │
│         │ Salut ! Tu connais│   │  ← bulle reçue (bg-tertiary)
│         │ ce spot ?         │   │
│         └───────────────────┘   │
│                          14:30  │  ← timestamp (caption, text-muted)
│                                 │
│   ┌───────────────────┐        │
│   │ Oui c'est génial !│        │  ← bulle envoyée (accent-teal, text inversé)
│   └───────────────────┘        │
│                    14:32  ✓✓   │  ← timestamp + read receipts
│                                 │
│─────────────────────────────────│
│  📎  [Message...          ] ➤  │  ← input bar
└─────────────────────────────────┘
```

## Tokens

- Background : `bg-primary`
- Bulle envoyée : `accent-teal` bg, `#000000` text
- Bulle reçue : `bg-tertiary` bg, `text-primary` text
- Rayon bulles : `radius-lg` (16px), coin de l'émetteur : 4px
- Padding bulle : 12px horizontal, 8px vertical
- Max width bulle : 75% de l'écran

## Composants

### Header
- Bouton retour (←) : icône flèche, tap → pop
- Avatar : 32px, `radius-full`
- Nom : `body`, bold, `text-primary`
- Status en ligne : cercle 8px, `success` si en ligne, `text-muted` si hors ligne
- Background : `bg-secondary`
- Height : 56px
- Shadow : `shadow-sm`

### Messages

#### Bulle envoyée (à droite)
- Background : `accent-teal`
- Texte : `#000000` (noir)
- Aligné à droite
- Rayon : 16px top-left, 16px top-right, 16px bottom-left, 4px bottom-right
- Timestamp sous la bulle, aligné droite

#### Bulle reçue (à gauche)
- Background : `bg-tertiary`
- Texte : `text-primary`
- Aligné à gauche
- Rayon : 16px top-left, 16px top-right, 4px bottom-left, 16px bottom-right
- Timestamp sous la bulle, aligné gauche

#### Date separator
- Texte : "Aujourd'hui", "Hier", ou date formatée
- Style : `caption`, `text-muted`, centré
- Ligne horizontale de chaque côté (1px, `border`)

#### Read receipts
- ✓ : envoyé
- ✓✓ : délivré
- ✓✓ (accent-teal) : lu
- Style : `caption`

### Input bar
- Background : `bg-secondary`
- Padding : `space-sm` vertical, `space-md` horizontal
- Input : `bg-tertiary`, `radius-full`, auto-resize (max 4 lignes)
- Bouton pièce jointe (📎) : icône, tap → sélection photo
- Bouton envoi (➤) : `accent-teal`, `radius-full`, 40px
- Le bouton envoi n'apparaît que si le champ n'est pas vide
- Safe area bottom padding pour iPhone

### Typing indicator
- 3 points animés dans une bulle côté gauche
- Animation : bounce séquentiel (100ms décalage)
- Apparaît quand l'autre utilisateur tape

## États

### Vide (nouvelle conversation)
- Message centré : "Envoyez votre premier message"
- Input bar visible

### Loading
- Spinner centré pendant le chargement initial
- Puis messages apparaissent

### Messages chargés
- Layout standard
- Scroll vers le bas au chargement initial
- Scroll automatique vers le bas à chaque nouveau message
- Pull vers le haut : charger les messages plus anciens (pagination)

### Error
- Banner en haut : "Message non envoyé. Tap pour réessayer"
- Background banner : `error` avec opacité

## Animations
- Nouveau message : slide up + fade in (200ms)
- Envoi de message : slide vers la droite dans la zone de bulles
- Typing indicator : 3 dots bounce loop
- Input bar : smooth resize au multiline
