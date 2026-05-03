# Project Brief: Lamicke Yoga WordPress to Wix Migration

## Meeting Context
- **Date:** May 3, 2026
- **Participants:** Atem
- **Current site:** [lamickeyoga.com](https://lamickeyoga.com/)
- **Target platform:** Wix

## Objective
Migrate the existing Lamicke Yoga website from WordPress to Wix, while preserving:
- content structure (pages, blog posts, media),
- visual identity (colors, typography, spacing, layout patterns),
- functional essentials (navigation, links, forms, SEO basics, domain/DNS).

## Why This Project
- Reduce friction in ongoing site editing by moving to Wix.
- Rebuild with AI-assisted design transfer to speed up delivery.
- Keep quality high by translating the current style system, not just copying text.

## Scope
### In Scope
- Extract style/design language from current WP site.
- Export and migrate content from WordPress.
- Rebuild the website in Wix with matching visual direction.
- QA pass for content, visual consistency, links, and mobile behavior.
- Domain/DNS cutover planning.

### Out of Scope (for first pass)
- Major rebrand or new visual identity.
- Advanced custom plugin feature parity unless explicitly required.
- Full SEO strategy rewrite beyond migration-safe basics.

## Proposed Migration Strategy
1. Extract design language from WordPress site using Google tooling.
2. Convert screenshots/style references into structured design assets.
3. Feed those assets into Claude/Codex for implementation guidance.
4. Use WordPress access (REST via WP-CLI) to extract content.
5. Recreate site in Wix using the design references and migrated content.

## Deliverables
- Migration brief and implementation plan (this docs set).
- Style reference pack (colors, typography, spacing, components).
- Content migration inventory and mapping (WP to Wix).
- Built Wix site ready for final QA and domain go-live.

## Success Criteria
- 100% of agreed pages moved and published on Wix.
- Visual match is close enough that brand identity is clearly preserved.
- No critical broken links or missing media on launch.
- Mobile and desktop both validated on key templates.
