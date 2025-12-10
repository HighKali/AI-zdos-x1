#!/usr/bin/env bash
set -euo pipefail
ROOT="${1:-./repos}"; TPL="./templates"
for d in "$ROOT"/*; do
  [ -d "$d" ] || continue
  echo "[*] Normalizzo $(basename "$d")"
  mkdir -p "$d/.github/workflows"
  cp "$TPL/ci.yml" "$d/.github/workflows/ci.yml"
  [ -f "$d/README.md" ] || cp "$TPL/README.md.tpl" "$d/README.md"
  [ -f "$d/SECURITY.md" ] || cp "$TPL/SECURITY.md.tpl" "$d/SECURITY.md"
  [ -f "$d/CODEOWNERS" ] || cp "$TPL/CODEOWNERS.tpl" "$d/CODEOWNERS"
  [ -f "$d/LICENSE" ] || cp "$TPL/LICENSE.tpl" "$d/LICENSE"
done
echo "[✓] Normalizzazione completa"
