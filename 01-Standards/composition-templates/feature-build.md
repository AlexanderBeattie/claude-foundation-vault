---
name: Feature Build Composition
description: 8-step load order for building a new feature end-to-end
type: composition-template
version: 1.0.0
---

# Feature Build — Composition Template

Use this template when implementing a new feature from requirements to merged code.

## 8-Step Load Order

| Step | Agent / Protocol | Action |
|------|-----------------|--------|
| 1 | `00-Core/laws.md` | Boot: confirm Sniper Protocol and Circuit Breaker are active |
| 2 | `02-Agents/core/planner.md` | Decompose the feature into atomic tasks; output a numbered task list |
| 3 | `02-Agents/core/architect.md` | Validate design — data model, API contracts, dependency graph |
| 4 | `02-Agents/core/tdd-guide.md` | Write failing tests first; confirm coverage targets |
| 5 | *(Implementation)* | Execute atomic tasks from Step 2; one commit per task |
| 6 | `02-Agents/reviewers/code-reviewer.md` | Full diff review — correctness, style, complexity |
| 7 | `02-Agents/reviewers/security-reviewer.md` | Security pass — inputs, auth, secrets, OWASP |
| 8 | `02-Agents/ops/doc-updater.md` | Update codemaps, changelog, and any affected docs |

## Context Mode

Load `01-Standards/Context-Modes/dev.md` for active coding sessions.

## When to Deviate

- **Hotfix**: skip Steps 2–3, go straight to Step 4.
- **Refactor only**: skip Step 3; replace Step 5 with `02-Agents/ops/refactor-cleaner.md`.
- **API-only change**: add `02-Agents/ops/docs-lookup.md` after Step 3 to verify external contracts.

## Skill Augmentation

Attach relevant skill packs from `03-Skills/` at Step 5 based on the tech stack:

```
python stack  → python-patterns, python-testing
go stack      → golang-patterns, golang-testing
typescript    → frontend-patterns, e2e-testing
database work → postgres-patterns, database-migrations
```
