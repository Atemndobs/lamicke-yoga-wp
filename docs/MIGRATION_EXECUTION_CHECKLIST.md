# Lamicke Yoga Migration Execution Checklist

Last updated: 2026-05-03 (post-FTP import)

## 1) Step Mapping: Proposed Workflow vs Existing Plan

| Proposed Step | Existing Plan Phase | Plan Reference | Primary Tooling |
|---|---|---|---|
| 1. Freeze source and define migration window | Phase 1: Discovery and Inventory | `WP_TO_WIX_MIGRATION_PLAN.md` | WordPress admin, stakeholder coordination |
| 2. Extract design system first | Phase 2: Style Extraction | `WP_TO_WIX_MIGRATION_PLAN.md` | Google Pomelli, Google Stitch, screenshots |
| 3. Extract structure/content from WordPress | Phase 3: Content Export from WordPress | `WP_TO_WIX_MIGRATION_PLAN.md` | WP-CLI/REST, DB dump, `wp-content` backup |
| 4. Build Wix shell (global + components) | Phase 4: Wix Build | `WP_TO_WIX_MIGRATION_PLAN.md` | Wix Editor / Wix CLI / Wix MCP |
| 5. Migrate pages in priority order | Phase 4: Wix Build | `WP_TO_WIX_MIGRATION_PLAN.md` | Wix Editor / Wix collections/pages |
| 6. Content placement + media relinking | Phase 4: Wix Build | `WP_TO_WIX_MIGRATION_PLAN.md` | Wix Editor, media manager |
| 7. Strict visual QA against source | Phase 5: QA and Fixes | `WP_TO_WIX_MIGRATION_PLAN.md` | Side-by-side manual QA, mobile/desktop validation |
| 8. SEO parity + redirects | Phase 5/6: QA + Cutover | `WP_TO_WIX_MIGRATION_PLAN.md` | URL map, metadata checks, redirect setup |
| 9. Launch and 48h monitoring | Phase 6: Cutover and Launch | `WP_TO_WIX_MIGRATION_PLAN.md` | DNS switch, smoke tests, monitoring |

## 2) Current Status Snapshot

### Completed
- [x] Local migration workspace initialized.
- [x] WordPress remote access path established (RESTful WP-CLI wrapper and auth setup).
- [x] Hostinger environment and hosting details captured.
- [x] Hostinger API token validated (account/service endpoints tested).
- [x] Wix CLI installed and authenticated (`wix whoami` -> `lamickeyoga`).
- [x] WordPress DB export present:
  - `exports/2026-05-03/db/u766744182_t4nt4.sql`
- [x] Full site file export present from FTP:
  - `exports/2026-05-03/lamickeyoga.com.zip`
  - extracted under `exports/2026-05-03/site_files/public_html/`
- [x] `wp-content` available locally for migration analysis:
  - `uploads` (~1498 files)
  - `themes` (~843 files)
  - `plugins` (~45336 files)
- [x] Site screenshot set captured in project:
  - `screenshots/` (EN + DE page set)
- [x] Pomelli style export assets present:
  - `exports/pomelli_business_dna/`
- [x] Plugin dependency mapping completed:
  - `docs/WP_PLUGIN_FEATURE_REPLACEMENTS.md`
  - `exports/2026-05-03/inventory/wp_plugins_status.csv`
- [x] Wix groundwork package prepared:
  - `docs/WIX_GROUNDWORK_SETUP.md`
  - `exports/2026-05-03/wix_groundwork/`

### In Progress
- [ ] Stitch-ready style package finalization (token cleanup + reusable component specs).

### Not Started
- [ ] Wix component library build.
- [ ] Wix page rebuild and content population.
- [ ] QA, SEO parity, redirect matrix, and launch.

## 3) Execution Checklist (Track This)

## Phase 0: Access and Setup
- [x] Confirm WP admin credentials.
- [x] Confirm Hostinger account/service visibility.
- [x] Confirm Wix account authentication via CLI.
- [x] Capture hosting/server metadata in docs.
- [ ] Confirm Wix target site/workspace ID and collaborators.

## Phase 1: Discovery and Inventory
- [x] Export URL inventory (all live pages/posts).
- [x] Export menu structure and locations.
- [x] Export media inventory (key assets and usage).
- [x] Mark plugin-dependent features needing Wix replacements.
- [ ] Freeze list of pages in scope for first release.

## Phase 2: Style Extraction
- [x] Capture desktop screenshots per template type.
- [ ] Capture mobile screenshots per template type.
- [x] Run Pomelli style extraction.
- [ ] Run Stitch asset generation.
- [ ] Produce final style pack (colors, typography, spacing, components).

## Phase 3: WordPress Content Export
- [x] Obtain SQL dump.
- [x] Obtain `wp-content` archive.
- [x] Generate structured inventory tables/files (CSV package; currently produced via authenticated WP API extraction).
- [ ] Create WP to Wix mapping sheet:
  - [x] URL to URL map
  - [x] Template to template map
  - [x] Media source to target map
  - [x] SEO field map

## Phase 4: Wix Build
- [ ] Create Wix site skeleton (pages, menus, basic routing).
- [ ] Implement global header/footer and navigation.
- [ ] Implement reusable component set from style pack.
- [ ] Build homepage to visual parity.
- [ ] Build key conversion pages (classes/pricing/contact).
- [ ] Build supporting pages.
- [ ] Build blog/archive structure (if in scope).

## Phase 5: QA and Fixes
- [ ] Desktop visual parity pass.
- [ ] Mobile visual parity pass.
- [ ] Link validation pass (internal/external).
- [ ] Forms and interactive behavior validation.
- [ ] Media and image crop/aspect validation.
- [ ] SEO parity validation (title/meta/slug/alt/canonicals as applicable).

## Phase 6: Cutover and Launch
- [ ] Final redirect matrix approved.
- [ ] DNS cutover plan finalized.
- [ ] Pre-launch smoke test on Wix published target.
- [ ] Domain switch executed.
- [ ] Post-launch smoke test complete.
- [ ] 48-hour monitoring complete with issue log closed.

## 4) Immediate Next Actions

- [x] Generate inventory files:
  - [x] `exports/2026-05-03/inventory/pages_inventory.csv` (13 pages)
  - [x] `exports/2026-05-03/inventory/posts_inventory.csv` (0 posts)
  - [x] `exports/2026-05-03/inventory/menus_inventory.csv` (13 menu items across 2 menus)
  - [x] `exports/2026-05-03/inventory/url_redirect_map.csv`
  - [x] `exports/2026-05-03/inventory/media_inventory.csv` (170 media items + parent-page hints)
  - [x] `exports/2026-05-03/inventory/page_media_usage.csv` (235 page-media usage rows)
  - [x] `exports/2026-05-03/inventory/media_source_to_wix_map.csv` (170 source entries for Wix target mapping)
  - [x] `exports/2026-05-03/inventory/template_to_wix_map.csv` (13 page templates mapped to Wix targets)
  - [x] `exports/2026-05-03/inventory/seo_field_map.csv` (13-page SEO parity baseline)
  - [x] `exports/2026-05-03/inventory/uploads_file_inventory.csv` (1498 uploaded files from FTP export)
  - [x] `exports/2026-05-03/inventory/wp_plugins_status.csv` (plugin status export)
- [ ] Create mobile screenshot set for key templates (home, classes, pricing, contact, shop).
- [ ] Normalize Pomelli output into final design token sheet for Wix implementation.
- [ ] Confirm launch scope decision: keep WooCommerce-equivalent store in phase-1 launch or defer store to phase-2.
- [ ] Open target Wix site/workspace and execute skeleton setup using `exports/2026-05-03/wix_groundwork/wix_pages_seed.csv`.
- [x] Validate whether `exports/2026-05-03/application-e543049a-3ae4-40da-98a0-db1f73019872.aab` is relevant to migration (not needed; unrelated Android app bundle).
- [x] Add media inventory extraction (`uploads` path map + key asset usage) to complete Phase 1.
