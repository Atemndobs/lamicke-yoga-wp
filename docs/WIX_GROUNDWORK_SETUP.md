# Wix Groundwork Setup (Ready to Execute)

Last updated: 2026-05-03

## Current Status

Groundwork artifacts are prepared locally under:
- `exports/2026-05-03/wix_groundwork/`

Generated files:
- `wix_pages_seed.csv` (target page list + template mapping + SEO baseline)
- `wix_navigation_seed.csv` (primary/social nav mapping, with exclusion notes)
- `wix_redirects_seed.csv` (WP old URL -> new URL baseline)
- `wix_build_order.csv` (recommended build order)
- `content_html/*.html` (13 page HTML exports for copy/rebuild in Wix)

Supporting inventories used:
- `exports/2026-05-03/inventory/template_to_wix_map.csv`
- `exports/2026-05-03/inventory/seo_field_map.csv`
- `exports/2026-05-03/inventory/media_source_to_wix_map.csv`
- `exports/2026-05-03/inventory/uploads_file_inventory.csv`

## What We Can Do Right Now

1. Build Wix skeleton pages from `wix_pages_seed.csv`.
2. Set navigation from `wix_navigation_seed.csv`.
3. Rebuild each page using `content_html/*.html` + screenshots.
4. Apply SEO metadata from `wix_pages_seed.csv`.
5. Prepare redirects from `wix_redirects_seed.csv`.

## Execution Sequence in Wix (Phase-1)

1. Open/create target Wix site.
2. Create pages in this order (`wix_build_order.csv`):
   - home, classes, pricing, contact, about, corporate-yoga, events, privacy-policy, impressum
3. Set global header/footer first, then build Home template sections.
4. Reuse those sections/components across interior pages.
5. Paste/rebuild page content from `content_html/<slug>.html`.
6. Replace image links using `media_source_to_wix_map.csv` as assets are uploaded.
7. Set SEO per page from `wix_pages_seed.csv`.
8. Configure redirects from `wix_redirects_seed.csv` before cutover.

## Important Scope Flag

WooCommerce pages exist in WP (`cart`, `checkout`, `my-account`) and are included in seed files as conditional pages.
Choose one:
- Include store in phase-1: set up Wix Stores now.
- Defer store to phase-2: exclude those 3 pages from phase-1 navigation and build.

## Wix Account / Target Site

- Logged in as `lamickeyoga` (verified via `wix whoami` under Node 22).
- Target site: **Lamicke Yoga** (`lamicke-yoga`)
  - metaSiteId: `6ee22a84-e12b-4725-a9c4-a148e56ef212`
  - htmlAppId: `aaf57183-6d7d-4141-8553-bbde35dd1f14`
  - editorType: `EDITOR` (classic Wix Editor)
  - published: false, premium: false, domainConnected: false
- REST API reachable (`/site-list/v2/sites/query` returns 200).

## Phase-1 Scope Decisions (2026-05-03)

- Store: **included in phase-1** — set up Wix Stores; build cart/checkout/my-account equivalents.
- Page scope: **frozen at the 13-page seed list** in `wix_pages_seed.csv` (incl. WooCommerce-equivalent pages).

## CLI/API Notes

- The installed `wix` CLI exposes auth-only commands (login/logout/token/whoami). No site/page mutation commands.
- Programmatic site mutation goes through Wix REST API directly, using `wix token` for the bearer token.
- The Wix REST API does not fully support classic Editor page/section creation — page layout work largely happens in the Editor UI. APIs are solid for: Stores, Bookings, Members, Data Collections, redirects, SEO settings, and media.
- Run any `wix` CLI or Node-based scripts under Node ≥ 20 (`nvm use 22.22.2`); system Node 16 is rejected by the CLI.
