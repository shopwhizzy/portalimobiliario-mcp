#!/bin/sh
# Builds dist/portal-imobiliario-<version>.zip: one folder (portal-imobiliario/) with plugin.json, mcp.json, LICENSE, skills/ and assets/ (what the OpenAI portal accepts).
set -e
cd "$(dirname "$0")/.."
V=$(python3 -c "import json;print(json.load(open('plugin.json'))['version'])")
T=$(mktemp -d); mkdir "$T/portal-imobiliario"
cp -r plugin.json mcp.json skills assets LICENSE "$T/portal-imobiliario/"
mkdir -p dist && rm -f "dist/portal-imobiliario-$V.zip"
(cd "$T" && zip -qr "$OLDPWD/dist/portal-imobiliario-$V.zip" portal-imobiliario)
rm -rf "$T"
echo "dist/portal-imobiliario-$V.zip"
