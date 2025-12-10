#!/usr/bin/env bash
set -euo pipefail
mkdir -p secrets
openssl genrsa -out secrets/jwt.key 2048
openssl rsa -in secrets/jwt.key -pubout -out secrets/jwt.pub
echo "[✓] JWKS generato in ./secrets"
