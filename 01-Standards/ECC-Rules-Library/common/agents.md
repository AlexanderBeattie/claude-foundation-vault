# Agent Orchestration

## Fixed Roles (V3 — injected by ignite.sh)

| Role | Purpose | Trigger |
|------|---------|---------|
| `architect` | System design, trade-offs | Architectural decisions |
| `code-reviewer` | Lang-specific review | After any code write |
| `planner` | Implementation planning | Complex features, refactoring |
| `security-reviewer` | Vulnerability analysis | Before commits, auth/input code |
| `tdd-guide` | Test-first enforcement | New features, bug fixes |

## Dispatch Rules

REQUIRE: Invoke `planner` before implementing any non-trivial feature.
REQUIRE: Invoke `code-reviewer` immediately after writing or modifying code.
REQUIRE: Invoke `tdd-guide` — write tests before implementation, always.
REQUIRE: Invoke `security-reviewer` on code touching user input, auth, or external APIs.
REQUIRE: Invoke `architect` for any decision affecting system structure.

## Parallel Execution

ENFORCE: Run independent agents in parallel. Never serialize agents with no data dependency.

## Context Discipline

STRICT: Spawn new sub-agent when approaching 80% context utilization.
STRICT: Pass only the minimum required context to each sub-agent.
