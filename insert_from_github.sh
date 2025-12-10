#!/usr/bin/env bash
set -euo pipefail

ROOT="$HOME/berzerk"
USER="HighKali"
DST="$ROOT/repos"

echo "[+] Estraggo i repository da GitHub utente: $USER"
mkdir -p "$DST"

# Lista repo con GitHub CLI
repos=$(gh repo list "$USER" --limit 100 --json name -q '.[].name')

for repo in $repos; do
  echo "[*] Clono $repo"
  [ -d "$DST/$repo" ] || gh repo clone "$USER/$repo" "$DST/$repo"
done

echo "[✓] Tutti i repo di $USER sono stati estrapolati e inseriti in $DST"

# Normalizzazione immediata
bash "$ROOT/scripts/normalize_repo.sh" "$DST"
