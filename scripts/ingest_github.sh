#!/usr/bin/env bash
set -euo pipefail
USER="${1:-HighKali}"
mkdir -p repos
echo "[+] Ingest da GitHub: $USER"
if ! command -v gh >/dev/null 2>&1; then
  echo "[!] gh non presente, salta ingest remoto"; exit 0
fi
repos=$(gh repo list "$USER" --limit 50 --json name -q '.[].name')
for repo in $repos; do
  [ -d "repos/$repo" ] || gh repo clone "$USER/$repo" "repos/$repo"
done
echo "[✓] Ingest completato"
