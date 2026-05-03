# Project Setup — Handoff to Lamike (Windows)

Last updated: 2026-05-03

This is the step-by-step setup guide for picking up the Lamicke Yoga
WordPress → Wix migration on a Windows machine. It assumes you have
the handoff email from Atem with two attachments / links:

1. **Two download links** (heavy export files — kept out of git on purpose)
2. **`docs/HOSTINGER_ENVIRONMENT_NOTES.md`** + **`.env`** (sensitive — also out of git)

If you don't have the email, ping Atem before starting.

---

## What this repo contains (and what it deliberately does not)

| In the repo | Out of the repo (delivered separately) |
|---|---|
| All planning docs (`docs/*.md`) | `docs/HOSTINGER_ENVIRONMENT_NOTES.md` (account/credentials) |
| All inventory CSVs and Wix groundwork seed files (`exports/2026-05-03/inventory/`, `exports/2026-05-03/wix_groundwork/`) | `.env` with WP credentials and download URLs |
| 13 page HTML exports for content rebuild (`exports/2026-05-03/wix_groundwork/content_html/`) | `lamickeyoga.com.zip` / `*.tar.gz` (full WordPress site backup, ~750 MB) |
| Pomelli style export (`exports/pomelli_business_dna/`) | `u766744182_t4nt4*.sql.gz` (WordPress DB dump, ~8 MB compressed / ~106 MB raw) |
| Screenshots (`screenshots/`) | |
| WP-CLI REST wrapper (`./wp`) and Wix scripts (`scripts/`) | |

The two heavy files are downloaded by a setup script using URLs you paste
into `.env`. They are reference-only — you do **not** need to spin up a
local WordPress to start building in Wix.

---

## One-time setup on your Windows machine

### 1. Install prerequisites

| Tool | Why | How |
|---|---|---|
| **Git for Windows** | Clone the repo, run bash scripts (Git Bash) | https://git-scm.com/download/win |
| **Node.js 20.11 or higher** (recommend 22 LTS) | The `wix` CLI requires Node ≥ 20.11. Node 16/18 will be rejected. | https://nodejs.org/  — pick the LTS installer. |
| **PowerShell 7+** (optional but recommended) | Better script support than Windows PowerShell 5. | https://github.com/PowerShell/PowerShell/releases |
| **Claude Code** | Drives the migration with the Wix MCP server | https://claude.com/product/claude-code |
| **GitHub CLI `gh`** (optional) | Easier auth + PR/issue work | https://cli.github.com/ |
| **7-Zip** (optional) | Extract `.tar.gz` and `.gz` files if your Windows version doesn't have `tar`/`gunzip`. Modern Windows 10/11 have `tar` built in. | https://www.7-zip.org/ |

After installing Node, open a fresh PowerShell and confirm:

```powershell
node --version    # must be v20.11.0 or higher
npm --version
git --version
```

### 2. Clone the repo

```powershell
cd $HOME\sites
git clone https://github.com/Atemndobs/lamicke-yoga-wp.git
cd lamicke-yoga-wp
```

### 3. Drop in the secret files Atem sent you

From the handoff email, save these to the project root:

- The `.env` Atem sent → save as `lamicke-yoga-wp\.env`  *(if you got URL placeholders only, see step 4 to fill them in)*
- `HOSTINGER_ENVIRONMENT_NOTES.md` Atem sent → save as `lamicke-yoga-wp\docs\HOSTINGER_ENVIRONMENT_NOTES.md`

Both filenames are listed in `.gitignore`, so they won't accidentally be committed.

If Atem only sent you a stub `.env`, copy the template first:

```powershell
Copy-Item .env.example .env
```

…then open `.env` in your editor and fill in the values from the email.

### 4. Paste the download URLs into `.env`

Atem will email you two download URLs. Open `.env` and set:

```
WP_SITE_BACKUP_URL=<paste URL #1 from email — full site backup, ~750 MB>
WP_DB_BACKUP_URL=<paste URL #2 from email — DB dump, ~8 MB>
```

> ⚠️ Hostinger backup URLs may be **time-limited**. Run the download script
> below soon after receiving the email. If a URL has expired, ask Atem to
> regenerate it from hPanel → Files → Backups.

### 5. Install the Wix CLI

```powershell
npm install -g @wix/cli
wix --version    # confirms install
wix login        # opens browser, log in as lamickeyoga
wix whoami       # should print "Logged in as lamickeyoga"
```

### 6. Download the heavy files

Run the PowerShell setup script from the project root:

```powershell
pwsh -File .\scripts\setup\download-heavy-files.ps1
```

(Or with Windows PowerShell 5: `powershell -ExecutionPolicy Bypass -File .\scripts\setup\download-heavy-files.ps1`)

This places:
- `exports\2026-05-03\lamickeyoga-site-backup.tar.gz` (~750 MB)
- `exports\2026-05-03\db\lamickeyoga-db.sql.gz` (~8 MB)

The script is **resumable** — re-run it if a download fails halfway.

To extract (only if you want to inspect WP files locally):

```powershell
tar -xzf .\exports\2026-05-03\lamickeyoga-site-backup.tar.gz -C .\exports\2026-05-03\
```

### 7. Connect Claude Code to the Wix MCP server

In Claude Code (CLI), run:

```
claude mcp add --transport http --scope user wix https://mcp.wix.com/mcp
```

Then in a Claude Code session run `/mcp`, pick **wix**, and complete the
browser OAuth as `lamickeyoga`. After approval Claude has direct API access
to the Wix site for site/page/Stores/Members/Bookings/Redirects/SEO operations.

To verify, ask Claude in your session:
> List my Wix sites.

You should see **Lamicke Yoga** with site ID `6ee22a84-e12b-4725-a9c4-a148e56ef212`.

---

## What's next (Phase 4 — Wix Build)

Open `docs/MIGRATION_EXECUTION_CHECKLIST.md` for the full state and the
phase checklist. Phase 4 is where you pick up. The seed files for the
Wix build are all in `exports/2026-05-03/wix_groundwork/`:

- `wix_pages_seed.csv` — 13 pages to create, with template mapping and SEO
- `wix_navigation_seed.csv` — primary + social nav
- `wix_redirects_seed.csv` — old WP URL → new Wix URL map
- `wix_build_order.csv` — recommended page build order
- `content_html/<slug>.html` — page content exports for copy-rebuild

`exports/2026-05-03/inventory/` has the full asset/SEO/template mapping CSVs.

### Recommended kickoff prompt for Claude Code

Once setup steps 1–7 are done, drop this into a fresh Claude Code session:

> I'm continuing the Lamicke Yoga WP→Wix migration on a Windows machine.
> The Wix MCP is connected and I'm authenticated as `lamickeyoga`. The
> target site ID is `6ee22a84-e12b-4725-a9c4-a148e56ef212` ("Lamicke Yoga").
> Read `docs/MIGRATION_EXECUTION_CHECKLIST.md` and `docs/WIX_GROUNDWORK_SETUP.md`
> to understand current state, then start Phase 4 by:
>   1. Listing the current pages on the Wix site,
>   2. Comparing them to `exports/2026-05-03/wix_groundwork/wix_pages_seed.csv`,
>   3. Proposing a concrete plan for creating the missing skeleton pages.
> Don't make any changes yet — wait for my approval after step 3.

---

## Troubleshooting

| Problem | Fix |
|---|---|
| `wix` CLI says "Node version 16.x detected, minimum is 20.11" | Install Node 20+ from nodejs.org and re-open PowerShell. Confirm with `node --version`. |
| `download-heavy-files.ps1` errors with "URL missing from .env" | Open `.env` and confirm `WP_SITE_BACKUP_URL` and `WP_DB_BACKUP_URL` are set with the URLs Atem emailed you. |
| Download URL returns 403/404 | Hostinger backup link expired. Ask Atem to regenerate it via hPanel → Files → Backups. |
| `tar` not found on Windows | Modern Windows 10/11 has `tar` built in. If yours doesn't, install 7-Zip and right-click → 7-Zip → Extract. |
| Can't push to GitHub | Authenticate with `gh auth login` or set up an SSH key per https://docs.github.com/en/authentication |
| Claude says Wix MCP "needs authentication" | Run `/mcp` in Claude Code, pick **wix**, complete the browser OAuth. |

---

## Conventions

- All paths in docs use POSIX form (`exports/2026-05-03/...`). Windows
  PowerShell accepts both `/` and `\`.
- Don't commit anything under `docs/HOSTINGER_ENVIRONMENT_NOTES.md`,
  `.env`, `exports/2026-05-03/site_files/`, `exports/2026-05-03/db/`,
  or `exports/2026-05-03/lamickeyoga.com.zip` — `.gitignore` enforces this.
- Run all `wix` CLI commands from a shell where `node --version` is ≥ 20.11.
