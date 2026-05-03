#!/usr/bin/env bash
# =============================================================================
# Lamicke Yoga — download heavy export artifacts (macOS / Linux)
# =============================================================================
# Reads WP_SITE_BACKUP_URL and WP_DB_BACKUP_URL from .env (project root) and
# downloads them into exports/2026-05-03/.
#
# Run from the project root:
#   ./scripts/setup/download-heavy-files.sh
# =============================================================================
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
ENV_FILE="$ROOT/.env"
EXPORT_DIR="$ROOT/exports/2026-05-03"
DB_DIR="$EXPORT_DIR/db"

if [[ ! -f "$ENV_FILE" ]]; then
  echo "Missing .env at $ENV_FILE. Copy .env.example to .env and fill in WP_SITE_BACKUP_URL and WP_DB_BACKUP_URL first." >&2
  exit 1
fi

# Load .env safely (only KEY=VALUE pairs)
set -a
# shellcheck disable=SC1090
source "$ENV_FILE"
set +a

: "${WP_SITE_BACKUP_URL:?WP_SITE_BACKUP_URL missing from .env (see handoff email)}"
: "${WP_DB_BACKUP_URL:?WP_DB_BACKUP_URL missing from .env (see handoff email)}"

mkdir -p "$EXPORT_DIR" "$DB_DIR"

download() {
  local url="$1"
  local out="$2"
  local label="$3"
  echo
  echo "[$label] -> $out"
  if [[ -f "$out" ]]; then
    echo "  Already present ($(du -h "$out" | cut -f1)). Skipping. Delete to re-download."
    return
  fi
  echo "  Downloading from $url ..."
  curl -fL --retry 3 --retry-delay 5 -C - -o "$out" "$url"
  echo "  Downloaded $(du -h "$out" | cut -f1)."
}

download "$WP_SITE_BACKUP_URL" "$EXPORT_DIR/lamickeyoga-site-backup.tar.gz" "WP site backup"
download "$WP_DB_BACKUP_URL"   "$DB_DIR/lamickeyoga-db.sql.gz"               "WP database dump"

cat <<EOF

Done. Files saved under exports/2026-05-03/.

Optional next steps:
  - Extract site backup:  tar -xzf exports/2026-05-03/lamickeyoga-site-backup.tar.gz -C exports/2026-05-03/
  - Decompress DB dump:   gunzip -k exports/2026-05-03/db/lamickeyoga-db.sql.gz

Both files are reference artifacts. You do not need to import them into a local
WordPress to start the Wix build.
EOF
