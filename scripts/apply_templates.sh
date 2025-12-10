#!/usr/bin/env bash
set -euo pipefail
REPO="$1"; TPL="./templates"
mkdir -p "$REPO/.github/workflows"
cp "$TPL/ci.yml" "$REPO/.github/workflows/ci.yml"
[ -f "$REPO/README.md" ] || cp "$TPL/README.md.tpl" "$REPO/README.md"
[ -f "$REPO/SECURITY.md" ] || cp "$TPL/SECURITY.md.tpl" "$REPO/SECURITY.md"
[ -f "$REPO/CODEOWNERS" ] || cp "$TPL/CODEOWNERS.tpl" "$REPO/CODEOWNERS"
[ -f "$REPO/LICENSE" ] || cp "$TPL/LICENSE.tpl" "$REPO/LICENSE"
echo "[✓] Templates applicati a $(basename "$REPO")"
