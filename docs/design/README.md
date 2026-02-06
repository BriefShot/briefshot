# Spécifications Design — BriefShot

## Design System

### Palette de couleurs

| Token | Hex | Usage |
|-------|-----|-------|
| `bg-primary` | `#0B1012` | Background principal |
| `bg-secondary` | `#131A1E` | Cards, surfaces élevées |
| `bg-tertiary` | `#1A2328` | Inputs, zones interactives |
| `accent-teal` | `#2DD4BF` | Boutons primaires, liens, éléments actifs |
| `accent-orange` | `#F97316` | CTAs, highlights, badges |
| `text-primary` | `#FFFFFF` | Texte principal |
| `text-secondary` | `#94A3B8` | Texte secondaire, labels |
| `text-muted` | `#64748B` | Texte désactivé, placeholders |
| `error` | `#EF4444` | Messages d'erreur |
| `success` | `#22C55E` | Confirmations |
| `border` | `#1E293B` | Bordures, séparateurs |

### Typographie

| Style | Font | Taille | Poids | Usage |
|-------|------|--------|-------|-------|
| `h1` | DrukWideWeb | 28px | Regular | Titres d'écran |
| `h2` | DrukWideWeb | 24px | Regular | Sous-titres |
| `h3` | System | 18px | Bold | Titres de section |
| `body` | System | 16px | Regular | Texte courant |
| `body-sm` | System | 14px | Regular | Texte secondaire |
| `caption` | System | 12px | Regular | Labels, timestamps |
| `button` | System | 14px | SemiBold | Texte des boutons |
| `overline` | System | 12px | Bold, uppercase | Tags, catégories |

### Espacement

| Token | Valeur | Usage |
|-------|--------|-------|
| `space-xs` | 4px | Espacement minimal |
| `space-sm` | 8px | Espacement entre éléments liés |
| `space-md` | 16px | Padding de cards, marges standard |
| `space-lg` | 24px | Séparation de sections |
| `space-xl` | 32px | Marges de page |
| `space-2xl` | 48px | Séparation majeure |

### Rayons de bordure

| Token | Valeur | Usage |
|-------|--------|-------|
| `radius-sm` | 8px | Tags, badges |
| `radius-md` | 12px | Boutons, inputs |
| `radius-lg` | 16px | Cards |
| `radius-xl` | 24px | Bottom sheets |
| `radius-full` | 999px | Avatars, pills |

### Ombres

| Token | Valeur | Usage |
|-------|--------|-------|
| `shadow-sm` | `0 1px 2px rgba(0,0,0,0.3)` | Éléments légèrement élevés |
| `shadow-md` | `0 4px 12px rgba(0,0,0,0.4)` | Cards, dropdowns |
| `shadow-lg` | `0 8px 24px rgba(0,0,0,0.5)` | Modals, bottom sheets |

### Animations

| Token | Valeur | Usage |
|-------|--------|-------|
| `duration-fast` | 150ms | Hovers, toggles |
| `duration-normal` | 300ms | Transitions de page, fades |
| `duration-slow` | 500ms | Animations complexes |
| `easing-default` | `ease-in-out` | Transitions standard |
| `easing-spring` | `cubic-bezier(0.34, 1.56, 0.64, 1)` | Bouncy, feedback tactile |

### Touch targets

- Minimum : 44x44px
- Recommandé : 48x48px
- Espacement entre targets : 8px minimum

## Specs par écran

| Écran | Fichier | Status |
|-------|---------|--------|
| Bottom sheet détail shot | [shot-detail-sheet.md](./shot-detail-sheet.md) | TODO (TICKET-008) |
| Liste de conversations | [message-list.md](./message-list.md) | TODO (TICKET-010) |
| Écran de chat | [chat-screen.md](./chat-screen.md) | TODO (TICKET-011) |
| Notifications | [notifications.md](./notifications.md) | TODO (TICKET-015) |

## Assets existants

### Icônes SVG (`assets/icons/`)

Icônes custom au format SVG, rendues via `flutter_svg`.

### Images (`assets/img/`)

Images de placeholder et de couverture par défaut.

### Fonts (`assets/fonts/`)

- **DrukWideWeb** — Font display pour les titres (Regular uniquement)
