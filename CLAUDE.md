# AI-Armoury — Command & Control Centre V4
<!-- Prompt-cache anchor: load 00-Core/ first on every session. -->

## Session Boot

1. Load `00-Core/laws.md` — Sniper Protocol (static laws, cache-stable)
2. Load `00-Core/circuit-breaker.md` — 3-strike failure protocol (cache-stable)
3. Load `00-Core/identity.md` — baseline persona (cache-stable)
4. Consult `REGISTRY.yaml` for all agent and skill paths

---

## Navigation

| Layer | Path | Purpose |
|---|---|---|
| Core (cache anchors) | `00-Core/` | Laws, circuit-breaker, identity — load first |
| Standards | `01-Standards/` | Context modes, rules library, composition templates |
| Agents | `02-Agents/` | Sub-agent personas grouped by role |
| Skills | `03-Skills/` | Domain knowledge (116 packs) |
| Workflows | `04-Workflows/` | Hooks, scripts, ignite.sh, install.sh |
| Blueprints | `05-Blueprints/` | Reference examples, setup guides |

## Agent Groups

| Group | Path | Contents |
|---|---|---|
| core | `02-Agents/core/` | architect, planner, tdd-guide |
| reviewers | `02-Agents/reviewers/` | 11 language & domain reviewers |
| resolvers | `02-Agents/resolvers/` | 7 build & compilation resolvers |
| ops | `02-Agents/ops/` | chief-of-staff, doc-updater, e2e-runner, + 4 more |

## Context Modes

| Mode | File | Use when |
|---|---|---|
| Dev | `01-Standards/Context-Modes/dev.md` | Active coding session |
| Research | `01-Standards/Context-Modes/research.md` | Investigation / discovery |
| Review | `01-Standards/Context-Modes/review.md` | Code review / audit |

Load with: `@01-Standards/Context-Modes/<mode>.md`

## Composition Templates

- Feature build (8-step): `01-Standards/composition-templates/feature-build.md`

## Absolute Paths

```
Armoury Root:    __VAULT_ROOT__
Registry:        __VAULT_ROOT__/REGISTRY.yaml
Ignite:          __VAULT_ROOT__/04-Workflows/ignite.sh
Installer:       __VAULT_ROOT__/04-Workflows/install.sh
Agents:          __VAULT_ROOT__/02-Agents/
Skills:          __VAULT_ROOT__/03-Skills/
Standards:       __VAULT_ROOT__/01-Standards/
MCP Templates:   __VAULT_ROOT__/04-Workflows/MCP-Templates/
```
