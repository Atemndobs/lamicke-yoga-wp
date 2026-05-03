#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
BIN_DIR="$ROOT_DIR/.bin"
WP_PHAR="$BIN_DIR/wp-cli.phar"

mkdir -p "$BIN_DIR"

if [[ ! -f "$WP_PHAR" ]]; then
  echo "Downloading WP-CLI..."
  curl -fsSL -o "$WP_PHAR" https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
  chmod +x "$WP_PHAR"
fi

echo "Installing wp-cli/restful (v0.4.1)..."
php -d error_reporting=E_ERROR "$WP_PHAR" package uninstall wp-cli/restful --allow-root >/dev/null 2>&1 || true
php -d error_reporting=E_ERROR "$WP_PHAR" package install wp-cli/restful:v0.4.1 --allow-root

echo "Done."
