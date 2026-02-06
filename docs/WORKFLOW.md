# Workflow de développement — BriefShot

## Philosophie

Tout travail passe par un ticket. Pas de code sans ticket, pas de merge sans review.

## Rôles

| Rôle | Responsabilité |
|------|---------------|
| **product** | Rédige les tickets, définit les critères d'acceptation, fait la validation finale |
| **designer** | Livre les specs UI/UX dans `/docs/design/`, valide les implémentations |
| **frontend** | Implémente les écrans, widgets, navigation, animations |
| **backend** | Implémente les repositories, BLoCs, entities, structure Firestore |
| **techlead** | Review de code, valide la qualité, maintient les standards |
| **qa** | Écrit les scénarios de test, valide les critères d'acceptation |

## Cycle de vie d'un ticket

```
BACKLOG → TODO → IN_PROGRESS → IN_REVIEW → QA → DONE
                      ↑                          │
                      └──── (rejeté) ─────────────┘
```

### Étapes détaillées

1. **BACKLOG** — product rédige le ticket avec critères d'acceptation
2. **TODO** — Le lead trie, assigne, prioritise et identifie les dépendances
3. **IN_PROGRESS** — L'assigné commence le travail
4. **IN_REVIEW** — Travail terminé, soumis au techlead pour review
5. **QA** — techlead a approuvé, qa valide les critères d'acceptation
6. **DONE** — qa a validé et product a accepté

### Cas de rejet

- **techlead rejette** → retour IN_PROGRESS avec commentaires de review
- **qa rejette** → retour IN_PROGRESS avec bug report (étapes de repro, attendu vs réel, sévérité)
- **product rejette** → retour IN_PROGRESS avec feedback sur les critères d'acceptation manqués

## Format d'un ticket

```
[TICKET-{ID}] {titre}
Status: BACKLOG | TODO | IN_PROGRESS | IN_REVIEW | QA | DONE | BLOCKED
Assignee: frontend | backend | designer | qa | techlead | product
Priority: P0 (critique) | P1 (haute) | P2 (moyenne) | P3 (basse)
Depends on: TICKET-{ID} (si applicable)
Blocks: TICKET-{ID} (si applicable)
Story points: 1 | 2 | 3 | 5 | 8
Description: ...
Acceptance criteria:
  - [ ] critère 1
  - [ ] critère 2
Review checklist:
  - [ ] techlead approved
  - [ ] qa validated
  - [ ] product accepted
```

## Règles de dépendance

- Un ticket ne peut pas passer en IN_PROGRESS si ses dépendances sont BLOCKED
- Les tickets design (designer) doivent être DONE avant les tickets frontend liés
- Les tickets de contrat API (backend) doivent être DONE avant l'intégration frontend
- Les scénarios de test (qa) doivent être DONE avant la phase QA d'une feature

## Workflow Git

### Branches

```
main
├── develop
│   ├── feature/TICKET-001-auth-tests
│   ├── feature/TICKET-006-dynamic-markers
│   ├── fix/TICKET-XXX-description
│   └── ...
```

### Processus

1. Créer une branche depuis `develop` : `feature/TICKET-{ID}-description`
2. Développer, commiter avec le format : `type(scope): description [TICKET-{ID}]`
3. Pousser et ouvrir une PR vers `develop`
4. Review par techlead
5. Merge après approbation
6. Mettre à jour le ticket

### Commits

```
feat(auth): add sign up unit tests [TICKET-001]
fix(map): load markers from Firestore [TICKET-006]
docs(design): add shot detail sheet spec [TICKET-008]
test(profile): add ProfileBloc unit tests [TICKET-002]
```

## Séquence de démarrage (Bootstrap)

1. product crée le backlog initial pour le MVP
2. Le lead trie et prioritise
3. designer prend les tickets design P0 en premier
4. backend prend les tickets API/structure P0 en parallèle
5. frontend, qa, techlead attendent leurs dépendances
6. Le flux continue naturellement

## Standup

Toutes les 10 tickets complétés, un point d'avancement :

```
BACKLOG: X | TODO: X | IN_PROGRESS: X | IN_REVIEW: X | QA: X | DONE: X

Bloqueurs :
- [TICKET-XXX] bloqué par ...

Prochaines priorités :
- [TICKET-XXX] ...
```

## Review checklist — techlead

### Frontend
- [ ] Pas de logique métier dans les composants
- [ ] Mémoisation correcte (const constructors, Equatable)
- [ ] Pas de prop drilling (utilisation de BlocProvider)
- [ ] Respect des specs design
- [ ] Gestion des états (loading, error, empty)
- [ ] Accessibilité (touch targets, labels)

### Backend
- [ ] Validation des inputs
- [ ] Gestion d'erreurs Firebase
- [ ] Pas de données sensibles en clair
- [ ] Entity immutable avec Equatable
- [ ] Repository découplé du BLoC

### Général
- [ ] Naming conventions respectées
- [ ] Pas de `any` type en TypeScript / `dynamic` en Dart
- [ ] Pas de code mort ou commenté
- [ ] Tests associés écrits

## Bug report — qa

```
[BUG] Titre
Sévérité: blocker | major | minor
Ticket lié: TICKET-{ID}

Étapes de reproduction:
1. ...
2. ...
3. ...

Résultat attendu:
...

Résultat actuel:
...

Device/OS:
...

Screenshots:
...
```
