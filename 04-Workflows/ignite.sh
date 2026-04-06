#!/usr/bin/env bash
# ignite.sh — AI-Armoury V3 High-Density Project Ignition
#
# FUNCTION: Detect project stack → inject role-aliased specialists into ./.claude/agents/
# RESULT:   Four canonical roles always present regardless of stack:
#             architect | code-reviewer | planner | security-reviewer
#
# USAGE: bash /path/to/claude-foundation-vault/04-Workflows/ignite.sh [PROJECT_ROOT]
#        (defaults to current directory if PROJECT_ROOT is omitted)
#
# Requires: bash 3.2+ (macOS compatible)

set -euo pipefail

# ── Resolve Armoury root (script lives in 04-Workflows/) ─────────────────────
SCRIPT_PATH="$0"
while [ -L "$SCRIPT_PATH" ]; do
    link_dir="$(cd "$(dirname "$SCRIPT_PATH")" && pwd)"
    SCRIPT_PATH="$(readlink "$SCRIPT_PATH")"
    [[ "$SCRIPT_PATH" != /* ]] && SCRIPT_PATH="$link_dir/$SCRIPT_PATH"
done
ARMOURY_ROOT="$(cd "$(dirname "$SCRIPT_PATH")/.." && pwd)"
CORE_DIR="$ARMOURY_ROOT/02-Agents/core"
REVIEWERS_DIR="$ARMOURY_ROOT/02-Agents/reviewers"

PROJECT_ROOT="${1:-$(pwd)}"
AGENTS_DIR="$PROJECT_ROOT/.claude/agents"

# ── Stack Detection ───────────────────────────────────────────────────────────
detect_primary_stack() {
    local root="$1"

    # TypeScript (check before JS)
    if [[ -f "$root/package.json" ]]; then
        if grep -q '"typescript"' "$root/package.json" 2>/dev/null || \
           find "$root" -maxdepth 3 -name "*.ts" 2>/dev/null | grep -q .; then
            echo "typescript"; return
        else
            echo "javascript"; return
        fi
    fi
    [[ -f "$root/go.mod" ]]           && echo "golang"  && return
    [[ -f "$root/Cargo.toml" ]]       && echo "rust"    && return
    [[ -f "$root/build.gradle.kts" ]] && echo "kotlin"  && return
    [[ -f "$root/pom.xml" ]]          && echo "java"    && return
    [[ -f "$root/build.gradle" ]]     && echo "java"    && return
    if [[ -f "$root/requirements.txt" || -f "$root/pyproject.toml" || -f "$root/setup.py" ]]; then
        echo "python"; return
    fi
    [[ -f "$root/Package.swift" ]]    && echo "swift"   && return
    [[ -f "$root/composer.json" ]]    && echo "php"     && return
    [[ -f "$root/CMakeLists.txt" ]]   && echo "cpp"     && return
    echo "generic"
}

# ── Resolve code-reviewer source for a given stack ───────────────────────────
resolve_code_reviewer() {
    case "$1" in
        typescript|javascript) echo "typescript-reviewer.md" ;;
        python)                echo "python-reviewer.md" ;;
        golang)                echo "go-reviewer.md" ;;
        rust)                  echo "rust-reviewer.md" ;;
        kotlin)                echo "kotlin-reviewer.md" ;;
        java)                  echo "java-reviewer.md" ;;
        cpp)                   echo "cpp-reviewer.md" ;;
        *)                     echo "code-reviewer.md" ;;
    esac
}

# ── Main ─────────────────────────────────────────────────────────────────────
echo "══ claude-foundation-vault Ignite V4 ════════════════════"
echo "  Armoury : $ARMOURY_ROOT"
echo "  Project : $PROJECT_ROOT"
echo ""

STACK="$(detect_primary_stack "$PROJECT_ROOT")"
CODE_REVIEWER_SRC="$(resolve_code_reviewer "$STACK")"

echo "  Primary stack    : $STACK"
echo "  Role alias map   :"
printf "    %-22s ← %s\n" "architect"        "architect.md"
printf "    %-22s ← %s\n" "code-reviewer"    "$CODE_REVIEWER_SRC"
printf "    %-22s ← %s\n" "planner"          "planner.md"
printf "    %-22s ← %s\n" "security-reviewer" "security-reviewer.md"
printf "    %-22s ← %s\n" "tdd-guide"        "tdd-guide.md (universal)"
echo ""

mkdir -p "$AGENTS_DIR"

INJECTED=0
SKIPPED=0

# inject ROLE SOURCE_FILE SRC_DIR [DEST_NAME]
inject() {
    local role="$1"
    local src_name="$2"
    local src_dir="$3"
    local dst_name="${4:-${role}.md}"
    local src="$src_dir/$src_name"
    local dst="$AGENTS_DIR/$dst_name"

    if [[ -f "$src" ]]; then
        cp "$src" "$dst"
        printf "  ✓  %-26s ← %s\n" "$dst_name" "$src_name"
        INJECTED=$(( INJECTED + 1 ))
    else
        printf "  ✗  %-26s — source not found: %s\n" "$dst_name" "$src"
        SKIPPED=$(( SKIPPED + 1 ))
    fi
}

inject "architect"         "architect.md"          "$CORE_DIR"
inject "code-reviewer"     "$CODE_REVIEWER_SRC"    "$REVIEWERS_DIR" "code-reviewer.md"
inject "planner"           "planner.md"            "$CORE_DIR"
inject "security-reviewer" "security-reviewer.md"  "$REVIEWERS_DIR"
inject "tdd-guide"         "tdd-guide.md"          "$CORE_DIR"      "tdd-guide.md"

echo ""
echo "  Injected : $INJECTED   Skipped : $SKIPPED"
echo "  Agents   : $AGENTS_DIR"
echo ""
echo "  Next: run /clear to activate the new context."
echo "══════════════════════════════════════════════════════════"
