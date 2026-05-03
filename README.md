# Lamicke Yoga — WordPress to Wix Migration

This repository tracks the migration of [lamickeyoga.com](https://lamickeyoga.com/)
from WordPress (Hostinger) to Wix. It contains the full planning docs,
content/asset inventories, Wix groundwork seed files, page HTML exports
for rebuild, and helper scripts.

**Target Wix site:** Lamicke Yoga (`6ee22a84-e12b-4725-a9c4-a148e56ef212`)

---

## Picking up the project (Lamike — start here)

If you're continuing this work on a new (Windows) machine, follow:

➡️ **[docs/SETUP_FOR_LAMIKE.md](docs/SETUP_FOR_LAMIKE.md)**

That guide walks through Node.js, Wix CLI, Claude Code + Wix MCP setup,
and how to download the two heavy export files (full site backup and DB
dump) using URLs from the handoff email.

---

## Repository layout

```
.
├── docs/                              # Planning, migration plan, checklists
│   ├── PROJECT_BRIEF.md
│   ├── WP_TO_WIX_MIGRATION_PLAN.md
│   ├── MIGRATION_EXECUTION_CHECKLIST.md       <-- track progress here
│   ├── WIX_GROUNDWORK_SETUP.md
│   ├── WP_PLUGIN_FEATURE_REPLACEMENTS.md
│   ├── SETUP_FOR_LAMIKE.md                    <-- Windows handoff guide
│   └── HOSTINGER_ENVIRONMENT_NOTES.example.md
│
├── exports/
│   ├── 2026-05-03/
│   │   ├── inventory/                 # Pages/posts/menus/media/SEO maps (CSV)
│   │   ├── wix_groundwork/            # Wix seed CSVs + 13 page HTML exports
│   │   ├── lamickeyoga.com.zip        (NOT in git — download via setup script)
│   │   ├── site_files/                (NOT in git — extracted from the zip)
│   │   └── db/                        (NOT in git — DB dump, download separately)
│   └── pomelli_business_dna/          # Style extraction (Google Pomelli)
│
├── meetings/                          # Meeting notes
├── screenshots/                       # Source-site visual references
├── scripts/
│   ├── setup-wp-cli.sh                # Bootstrap WP-CLI restful wrapper
│   ├── setup/
│   │   ├── download-heavy-files.ps1   # Windows downloader for heavy exports
│   │   └── download-heavy-files.sh    # macOS/Linux equivalent
│   └── wix/                           # Wix automation scripts (in progress)
│
├── wp                                 # WP-CLI restful wrapper (executable)
├── .env.example                       # Copy to .env and fill in
└── README.md                          # this file
```

---

## Status snapshot

Phases 0–3 (access, discovery, content export, inventories, Wix groundwork)
are complete. The current focus is **Phase 4: Wix Build** in the live Wix
site, driven through the Wix MCP server in Claude Code.

See **`docs/MIGRATION_EXECUTION_CHECKLIST.md`** for the always-current task
checklist.

---

## Quick start (already-set-up environment)

```bash
# 1) Configure environment
cp .env.example .env
# edit .env — fill in WP creds and download URLs from the handoff email

# 2) WP-CLI REST against the live site
./scripts/setup-wp-cli.sh
./wp rest

# 3) Wix CLI (requires Node ≥ 20.11)
wix login
wix whoami    # -> "Logged in as lamickeyoga"

# 4) Download the heavy export artifacts
./scripts/setup/download-heavy-files.sh        # macOS/Linux
# or on Windows:
#   pwsh -File .\scripts\setup\download-heavy-files.ps1

# 5) Connect Claude Code to the Wix MCP server
claude mcp add --transport http --scope user wix https://mcp.wix.com/mcp
# then in Claude Code: /mcp -> select wix -> complete browser OAuth
```

---

## What's NOT in this repo (and why)

| Excluded | Reason | Where to get it |
|---|---|---|
| `.env` | Secrets (WP credentials, download URLs) | Sent by Atem in the handoff email |
| `docs/HOSTINGER_ENVIRONMENT_NOTES.md` | Hosting credentials, API tokens | Sent by Atem in the handoff email |
| `exports/2026-05-03/lamickeyoga.com.zip` (~1.4 GB) | GitHub file size limit | URL in `.env` → `download-heavy-files.ps1` |
| `exports/2026-05-03/site_files/` | Re-derivable by extracting the zip | Extract the zip after download |
| `exports/2026-05-03/db/*.sql*` | Contains PII / WP user hashes | URL in `.env` → `download-heavy-files.ps1` |

Everything else (planning docs, inventory CSVs, Wix groundwork seeds,
page HTML, screenshots, Pomelli style export, scripts) IS in the repo.
