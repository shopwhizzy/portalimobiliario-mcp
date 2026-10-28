#!/bin/sh
# Builds dist/portal-imobiliario-<version>.zip: one folder (portal-imobiliario/) with the plugin files, as the OpenAI portal expects.
set -e
cd "$(dirname "$0")/.."
V=$(python3 -c "import json;print(json.load(open('plugin.json'))['version'])")
T=$(mktemp -d); mkdir "$T/portal-imobiliario"
cp -r plugin.json mcp.json .mcp.json .claude-plugin skills assets LICENSE README.md "$T/portal-imobiliario/"
mkdir -p dist && rm -f "dist/portal-imobiliario-$V.zip"
(cd "$T" && zip -qr "$OLDPWD/dist/portal-imobiliario-$V.zip" portal-imobiliario)
rm -rf "$T"
echo "dist/portal-imobiliario-$V.zip"
