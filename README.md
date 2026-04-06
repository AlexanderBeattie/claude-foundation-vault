# claude-foundation-vault

**Agentic Operating System optimized for Claude 4.6 Prefix Caching**

A structured, cache-aware infrastructure for deploying Claude Code agents across any project. Designed to work alongside [Everything Claude Code](https://github.com/affaan-m/everything-claude-code) as a high-performance project "Brain."

---

## V4 Architecture — The Context Pyramid

The vault is organized as a four-layer hierarchy designed to maximize Claude's prefix cache hit rate. Layers loaded earlier are more cache-stable and shared across sessions.

```text
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

---

## Hybrid Installation (The 2026 Standard)

To get the ultimate environment, we use Everything Claude Code (ECC) for global terminal commands and Claude Foundation Vault (CFV) for project-level logic.

### 1. Install Global Tools (ECC Plugin)

First, install ECC to get access to global commands like `/cost`, `/sessions`, and `/pm2`.

```bash
git clone [https://github.com/affaan-m/everything-claude-code.git](https://github.com/affaan-m/everything-claude-code.git) ~/development/everything-claude-code
cd ~/development/everything-claude-code
npm install

# Manually link the ECC "Hands" (Commands) and "Muscle" (Scripts)
mkdir -p ~/.claude/commands ~/.claude/scripts ~/.claude/skills
cp -r commands/*.md ~/.claude/commands/
cp -r scripts/* ~/.claude/scripts/
cp -r skills/* ~/.claude/skills/
```

### 2. Install the Project Brain (This Vault)

Clone this repository and bootstrap it to resolve local absolute paths.

```bash
git clone https://github.com/AlexanderBeattie/claude-foundation-vault.git ~/development/claude-foundation-vault
cd ~/development/claude-foundation-vault
./bootstrap.sh
```

### 3. Ignite a Project

Navigate to any project root and launch Claude:

```bash
cd ~/path/to/your-project
claude
```

Paste the contents of `~/development/claude-foundation-vault/Prompt.md` into the chat. Claude will automatically:

- Audit your stack.
- Inject the V4 Triad (Architect, Planner, Reviewer).
- Forge a modular `CLAUDE.md` wired to the vault.

### 4. Activate Cache

Once the injection is complete, run the reset command:

```bash
/clear
```

---

## Global Rules — Recommended `settings.json` env Block

Add these to `~/.claude/settings.json` under `"env"` to configure subagent model routing and token limits:

```json
{
  "env": {
    "CLAUDE_CODE_SUBAGENT_MODEL": "haiku",
    "MAX_THINKING_TOKENS": "10000",
    "CLAUDE_AUTOCOMPACT_PCT_OVERRIDE": "50"
  },
  "model": "sonnet"
}
```

| Variable | Value | Effect |
|---|---|---|
| `CLAUDE_CODE_SUBAGENT_MODEL` | `haiku` | Routes all sub-agents to Haiku 4.5 — 3× cheaper for worker tasks |
| `MAX_THINKING_TOKENS` | `10000` | Caps extended thinking budget per call (default is 31,999) |
| `CLAUDE_AUTOCOMPACT_PCT_OVERRIDE` | `50` | Triggers auto-compaction at 50% context usage instead of 80% |
| `model` | `sonnet` | Main orchestrator stays on Sonnet 4.6 for complex reasoning |

> **Why this matters for the vault:** `ignite.sh` spawns multiple sub-agents during stack detection and injection. Without `CLAUDE_CODE_SUBAGENT_MODEL=haiku`, every sub-agent defaults to Sonnet — multiplying cost on every project boot.

---

## Caching Economics

Claude 4.6 caches repeated prompt prefixes. By moving project rules into the Foundation Vault, we achieve:

| Metric | Legacy Context | V4 Cache Strategy |
|---|---|---|
| 00-Core cost | Billed every call | ~90% reduction |
| Response Latency | High (full processing) | ~80% reduction |
| Baseline Window | 15k - 20k tokens | < 2k tokens |

---

## Directory Reference

```
claude-foundation-vault/
├── 00-Core/                    # Cache anchors (laws, circuit-breaker, identity)
├── 01-Standards/               # ECC-Rules-Library & Context Modes
├── 02-Agents/                  # Sub-agent personas (core, reviewers, resolvers)
├── 03-Skills/                  # 116 domain knowledge packs (Loaded on-demand)
├── 04-Workflows/               # ignite.sh, install.sh, & bootstrap scripts
├── 05-Blueprints/              # Setup guides and reference CLAUDE.md files
├── REGISTRY.yaml               # Source of truth for all resource paths
└── Prompt.md                   # The "One-Shot" Project Initializer
```

---

## Requirements

- Claude Code CLI v2.1.0+
- bash 3.2+ (macOS/Linux)

---

## License

MIT
