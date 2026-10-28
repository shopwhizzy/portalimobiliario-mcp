#!/bin/sh
# Builds dist/portal-imobiliario-<version>.zip with the plugin files at the root of the archive.
set -e
cd "$(dirname "$0")/.."
V=$(python3 -c "import json;print(json.load(open('plugin.json'))['version'])")
mkdir -p dist && rm -f "dist/portal-imobiliario-$V.zip"
zip -qr "dist/portal-imobiliario-$V.zip" plugin.json mcp.json .mcp.json .claude-plugin skills assets LICENSE README.md
echo "dist/portal-imobiliario-$V.zip"
