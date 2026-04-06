#!/usr/bin/env bash
# bootstrap.sh — claude-foundation-vault path resolver
# Run once after cloning to bind __VAULT_ROOT__ to this machine's absolute path.

set -euo pipefail

# ── 1. Detect vault root ──────────────────────────────────────────────────────
VAULT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PLACEHOLDER="__VAULT_ROOT__"

echo ""
echo "claude-foundation-vault bootstrap"
echo "=================================="
echo "Vault root: $VAULT_ROOT"
echo ""

# ── 2. BSD / GNU sed compatibility ───────────────────────────────────────────
if sed --version 2>/dev/null | grep -q GNU; then
    SED_INPLACE=(-i)
else
    SED_INPLACE=(-i '')   # macOS BSD sed
fi

# ── 3. Replace placeholder in all .yaml, .md, .json files ───────────────────
REPLACED=0
SKIPPED=0

while IFS= read -r -d '' file; do
    if grep -qF "$PLACEHOLDER" "$file" 2>/dev/null; then
        sed "${SED_INPLACE[@]}" "s|${PLACEHOLDER}|${VAULT_ROOT}|g" "$file"
        printf "  ✓  %s\n" "${file#"$VAULT_ROOT/"}"
        REPLACED=$(( REPLACED + 1 ))
    fi
done < <(find "$VAULT_ROOT" \
    \( -name ".git" -o -name "node_modules" \) -prune -o \
    \( -name "*.yaml" -o -name "*.yml" -o -name "*.md" -o -name "*.json" \) \
    -print0)

echo ""
echo "Replaced $PLACEHOLDER in $REPLACED file(s)."

# ── 4. Ensure scripts are executable ─────────────────────────────────────────
chmod +x "$VAULT_ROOT/bootstrap.sh"
chmod +x "$VAULT_ROOT/04-Workflows/ignite.sh" 2>/dev/null || true

echo ""
if [[ $REPLACED -gt 0 ]]; then
    echo "Bootstrap complete. Vault is ready at:"
    echo "  $VAULT_ROOT"
else
    echo "No placeholders found — vault may already be bootstrapped."
fi
echo ""
