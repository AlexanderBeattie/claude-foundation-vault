**Role**: Lead AI Architect (V3 — Ignite Architecture)

## Setup Workflow

### 1. Audit Phase

```bash
ls -R . | head -40
cat package.json 2>/dev/null || cat go.mod 2>/dev/null || cat pyproject.toml 2>/dev/null
```

Identify: Language, Frameworks, Databases, Testing suite.

### 2. Ignition Phase (local, project-scoped — no global writes)

Run `ignite.sh` from the project root. It auto-detects stack and injects role-aliased specialists.

```bash
bash __VAULT_ROOT__/04-Workflows/ignite.sh
```

What `ignite.sh` does:
- Detects stack (TypeScript, Python, Go, Rust, Java, Kotlin, Swift, PHP, C++)
- Maps stack-specific reviewer to canonical role `code-reviewer`
- Writes to `./.claude/agents/` — never to global user directory
- Canonical roles always present regardless of stack:

| Role | Source (example: TS project) |
|------|------------------------------|
| `architect.md` | `architect.md` |
| `code-reviewer.md` | ← `typescript-reviewer.md` |
| `planner.md` | `planner.md` |
| `security-reviewer.md` | `security-reviewer.md` |
| `tdd-guide.md` | `tdd-guide.md` (universal) |

CLAUDE.md orchestration table never changes — only the alias mapping in `ignite.sh` does.

### 3. Rules Injection

Copy relevant protocol rules into local `./.claude/CLAUDE.md`:

```bash
# Example: TypeScript project
cat __VAULT_ROOT__/01-Protocols/ECC-Rules-Library/common/agents.md >> ./.claude/CLAUDE.md
cat __VAULT_ROOT__/01-Protocols/ECC-Rules-Library/common/security.md >> ./.claude/CLAUDE.md
cat __VAULT_ROOT__/01-Protocols/ECC-Rules-Library/typescript/coding-style.md >> ./.claude/CLAUDE.md
```

### 4. Settings

Create `./.claude/settings.json` with project-specific overrides only. Inherit env and permissions from global.

```json
{
  "permissions": {
    "allow": []
  }
}
```

### 5. Activation

```bash
# Final step: clear context to load new agents
/clear
```

---

## Path Policy

STRICT: All paths in project `.claude/` files use relative paths (`./.claude/`).
STRICT: No absolute user-home paths in committed project files.
STRICT: Global user directory (`~/.claude/agents/`) remains empty — all agents are project-local.

## Stack → Reviewer Map (reference)

| Stack | `code-reviewer` source |
|-------|----------------------|
| TypeScript / JS | `typescript-reviewer.md` |
| Python | `python-reviewer.md` |
| Go | `go-reviewer.md` |
| Rust | `rust-reviewer.md` |
| Kotlin | `kotlin-reviewer.md` |
| Java | `java-reviewer.md` |
| C++ | `cpp-reviewer.md` |
| Swift / PHP / Generic | `code-reviewer.md` |
