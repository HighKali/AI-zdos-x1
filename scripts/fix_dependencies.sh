#!/usr/bin/env bash
set -euo pipefail
REPO="$1"; pushd "$REPO" >/dev/null
if [ -f package.json ]; then
  echo "[*] Node deps fix"
  if command -v pnpm >/dev/null 2>&1; then pnpm install --frozen-lockfile || true
  elif command -v npm >/dev/null 2>&1; then npm ci || npm install || true
  elif command -v yarn >/dev/null 2>&1; then yarn --frozen-lockfile || yarn || true
  fi
fi
if [ -f requirements.txt ]; then
  echo "[*] Python deps fix"; python -m pip install -r requirements.txt || true
fi
if [ -f go.mod ]; then echo "[*] Go deps fix"; go mod tidy || true; fi
if [ -f Cargo.toml ]; then echo "[*] Rust deps fix"; cargo update || true; fi
popd >/dev/null
echo "[✓] Dipendenze sistemate per $(basename "$REPO")"
