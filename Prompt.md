*CLAUDE IGNORE THIS*
Act as the Lead System Architect. We are initializing this project using the AI-Armoury V4 (Cache-Optimized) protocols.

TASK 1: TECH AUDIT
- Briefly scan the root directory and package.json to identify the tech stack (Framework, Language, DB).

TASK 2: ARMOURY INJECTION (V4)
- Create the local project directories: mkdir -p ./.claude/agents/ and ./.claude/rules/
- Consult the Master Registry at __VAULT_ROOT__/REGISTRY.yaml.
- COPY (cp) the following core assets from the V4 Armoury into this project:
    - Core Core: 00-Core/* -> ./.claude/
    - Core Agents: 02-Agents/core/architect.md & 02-Agents/core/planner.md -> ./.claude/agents/
    - Global Rules: 01-Standards/rules/common/* -> ./.claude/rules/common/
    - [Based on audit: COPY the relevant language-specific dir from 01-Standards/rules/ into ./.claude/rules/]

TASK 3: FORGE LOCAL IDENTITY
- Create a project-specific CLAUDE.md in the root using the V4 Command & Control template.
- State the "Project Mission" clearly at the top.
- Map the "Absolute Paths" section to the Master Armoury in __VAULT_ROOT__/.

TASK 4: ENGINE IGNITION
- Run the V4 'ignite' script to finalize the logic binding:
  bash __VAULT_ROOT__/04-Workflows/ignite.sh [detected_stack]

Once complete, verify that you can 'grep' the local ./.claude/agents/ for the 'architect' ID and confirm you are ready to operate.