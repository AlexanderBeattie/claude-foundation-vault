# Coding Style

## Immutability

STRICT: Create new objects. Never mutate existing ones.
```
WRONG:  modify(original, field, value)  → mutates in-place
CORRECT: update(original, field, value) → returns new copy
```

## File Organization

ENFORCE: Many small files over few large files.
- 200–400 lines typical. 800 lines hard max.
- Organize by feature/domain, not by type.
- Extract utilities when a module exceeds limits.

## Error Handling

STRICT: Handle errors explicitly at every call site.
STRICT: Never silently swallow errors — empty catch blocks are forbidden.
STRICT: User-facing messages are friendly. Server logs contain full context.

## Input Validation

STRICT: Validate at system boundaries only (user input, external APIs, file content).
STRICT: Use schema-based validation where available.
STRICT: Fail fast with a clear error message.
STRICT: Never trust external data.

## Code Quality Gate

Before marking work complete:
- [ ] Functions < 50 lines
- [ ] Files < 800 lines
- [ ] Nesting depth ≤ 4 levels
- [ ] No magic numbers — use named constants or config
- [ ] No mutation — immutable patterns throughout
- [ ] Errors handled at every level
