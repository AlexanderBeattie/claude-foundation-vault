# claude-foundation-vault

**Agentic Operating System optimized for Claude 4.6 Prefix Caching**

A structured, cache-aware infrastructure for deploying Claude Code agents across any project. Drop the vault into your workflow, run one script, and get a full agent team — architect, code-reviewer, planner, security-reviewer, tdd-guide — wired to your stack in under 30 seconds.

---

## V4 Architecture — The Context Pyramid

The vault is organized as a four-layer hierarchy designed to maximize Claude's prefix cache hit rate. Layers loaded earlier are more cache-stable and shared across sessions.

```
┌─────────────────────────────────────────┐
│  00-Core          Cache Anchors         │  ← Load once. Never change mid-session.
│  laws · circuit-breaker · identity      │    Highest cache stability.
├─────────────────────────────────────────┤
│  01-Standards     Rules Library         │  ← Language rules, context modes,
│  ECC-Rules-Library · Context-Modes      │    composition templates.
├─────────────────────────────────────────┤
│  02-Agents        Sub-Agent Personas    │  ← Role-aliased specialists injected
│  core · reviewers · resolvers · ops     │    per-project by ignite.sh.
├─────────────────────────────────────────┤
│  03-Skills        Domain Knowledge      │  ← 116 skill packs. Load on demand.
│  116 packs across all major stacks      │    Lowest cache priority.
└─────────────────────────────────────────┘
```

| Layer | Path | Purpose |
|---|---|---|
| Cache Anchors | `00-Core/` | Laws, circuit-breaker, identity — load first on every session |
| Standards | `01-Standards/` | Context modes, ECC rules library, composition templates |
| Agents | `02-Agents/` | Sub-agent personas grouped by role |
| Skills | `03-Skills/` | Domain knowledge packs, loaded on demand |
| Workflows | `04-Workflows/` | `ignite.sh`, `install.sh`, hooks, MCP templates |
| Blueprints | `05-Blueprints/` | Reference CLAUDE.md examples, setup guides |

### Agent Groups

| Group | Path | Agents |
|---|---|---|
| `core` | `02-Agents/core/` | architect, planner, tdd-guide |
| `reviewers` | `02-Agents/reviewers/` | 11 language & domain reviewers |
| `resolvers` | `02-Agents/resolvers/` | 7 build & compilation resolvers |
| `ops` | `02-Agents/ops/` | chief-of-staff, doc-updater, e2e-runner, + 4 more |

---

## The Financial Benefit — Why Prefix Caching Matters

Claude 4.6 caches repeated prompt prefixes across API calls. The V4 architecture is designed to exploit this aggressively.

| Metric | Without Caching | With V4 Cache Strategy |
|---|---|---|
| `00-Core` token cost | Billed every call | **~90% reduction** (cache hit) |
| Time-to-first-token | Full prompt processing | **~80% latency reduction** |
| Cross-session cost | Compounds per session | Amortized after first load |

**How it works:** `00-Core/` (laws, circuit-breaker, identity) is loaded at the top of every session in a fixed order. Because the text never changes, Claude's API returns a cache hit on every subsequent call — you pay only for the new tokens. The pyramid structure ensures the most-reused content sits at the highest cache-stability position in the prompt.

---

## Installation

### 1. Clone the vault

```bash
git clone https://github.com/your-username/claude-foundation-vault.git ~/development/claude-foundation-vault
```

### 2. Run the ignition script inside your project

Navigate to any project root and run:

```bash
bash ~/development/claude-foundation-vault/04-Workflows/ignite.sh
```

`ignite.sh` will:
- Auto-detect your project stack (TypeScript, Python, Go, Rust, Java, Kotlin, Swift, PHP, C++)
- Map the stack-specific reviewer to the canonical `code-reviewer` role
- Inject four fixed agents into `./.claude/agents/` — regardless of stack:

| Agent | Source (TypeScript example) |
|---|---|
| `architect.md` | `02-Agents/core/architect.md` |
| `code-reviewer.md` | ← `02-Agents/reviewers/typescript-reviewer.md` |
| `planner.md` | `02-Agents/core/planner.md` |
| `security-reviewer.md` | `02-Agents/reviewers/security-reviewer.md` |
| `tdd-guide.md` | `02-Agents/core/tdd-guide.md` |

### 3. Load the CLAUDE.md

Copy `CLAUDE.md` from this vault to your project root (or merge it with an existing one). It boots the `00-Core` anchors and points Claude at the registry.

### 4. Activate

```
/clear
```

Claude Code reloads context with the new agents active.

---

## Local Setup — Path Configuration

> **Required for all new users. Run once immediately after cloning.**

Configuration files use a `__VAULT_ROOT__` placeholder that must be resolved to your local clone path before use. A single script handles this automatically:

```bash
./bootstrap.sh
```

The script:
- Auto-detects the vault's absolute path (works regardless of where you cloned it)
- Replaces `__VAULT_ROOT__` across all `.yaml`, `.md`, and `.json` files
- Marks itself and `04-Workflows/ignite.sh` as executable

Verify the replacement:

```bash
grep -r "__VAULT_ROOT__" . --include="*.md" --include="*.yaml" --include="*.json"
# Should return nothing
```

---

## Directory Reference

```
claude-foundation-vault/
├── 00-Core/                    # Cache anchors — load first
│   ├── laws.md                 # Sniper Protocol operating laws
│   ├── circuit-breaker.md      # 3-strike failure protocol
│   └── identity.md             # Baseline agent persona
├── 01-Standards/
│   ├── Context-Modes/          # dev · research · review
│   ├── ECC-Rules-Library/      # Language rules (common + 10 languages)
│   └── composition-templates/  # Feature-build orchestration templates
├── 02-Agents/
│   ├── core/                   # architect · planner · tdd-guide
│   ├── reviewers/              # 11 language & domain reviewers
│   ├── resolvers/              # 7 build & compilation resolvers
│   └── ops/                    # chief-of-staff · doc-updater · e2e-runner · +4
├── 03-Skills/                  # 116 domain knowledge packs
├── 04-Workflows/
│   ├── ignite.sh               # Stack-detection + agent injection
│   ├── install.sh              # Rules library installer
│   ├── hooks/                  # Claude Code hook definitions
│   ├── scripts/                # Supporting JS utilities
│   └── MCP-Templates/          # MCP server configuration templates
├── 05-Blueprints/
│   ├── Setup-New-Project.md    # Step-by-step ignition guide
│   └── Reference-Examples/     # Reference CLAUDE.md files per stack
├── CLAUDE.md                   # Command & Control — load this in your project
├── REGISTRY.yaml               # Source of truth for all agent & skill paths
└── Prompt.md                   # Bootstrap prompt for new project ignition
```

---

## Requirements

- [Claude Code](https://claude.ai/code) CLI
- bash 3.2+ (macOS compatible)
- Git

---

## License

MIT
