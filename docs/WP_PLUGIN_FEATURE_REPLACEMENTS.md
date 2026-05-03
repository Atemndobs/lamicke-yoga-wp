# WP Plugin Feature Replacements for Wix

Last updated: 2026-05-03
Source inventory: `exports/2026-05-03/inventory/wp_plugins_status.csv`

## Migration-Relevant Active Plugins

| WP Plugin(s) | Current Role on WP Site | Wix Replacement Path | Priority |
|---|---|---|---|
| `elementor`, `elementor-pro`, `elementskit-lite`, `happy-elementor-addons`, `sticky-header-effects-for-elementor`, `olympus-google-fonts` | Page builder, layout components, global styling, sticky nav, custom typography | Rebuild templates/components in Wix Editor/Studio using reusable sections + site theme tokens | P0 |
| `contact-form-7`, `forminator`, `wpforms-lite`, `easy-wp-smtp`, `mailpoet` | Contact/lead forms, form email delivery, mailing workflows | Wix Forms + Wix CRM + Wix Automations for submit flows and follow-ups | P0 |
| `woocommerce`, `woocommerce-payments`, `woocommerce-services`, `facebook-for-woocommerce`, `google-listings-and-ads`, `pinterest-for-woocommerce`, `tiktok-for-business` | Store, checkout/cart/account, payment/tax/shipping, channel sync | Wix Stores + Wix Payments + shipping/tax configuration + optional channel apps | P0 (if e-commerce remains in scope) |
| `seo-by-rank-math` | Page SEO metadata and indexing controls | Wix SEO page settings and SEO defaults per page/type | P0 |
| `translatepress-multilingual` | EN/DE multilingual site delivery | Wix Multilingual with language visibility + translation workflow | P0 |
| `cookie-law-info` | GDPR cookie consent banner | Usercentrics for Wix consent banner (current Wix path) | P0 |
| `instagram-feed` | Instagram feed embedding | Wix social/Instagram embed app or section-level embeds | P1 |
| `jetpack`, `w3-total-cache` | Performance/security/utility enhancements | Mostly replaced by Wix hosting/runtime defaults; re-check analytics/security needs separately | P1 |
| `updraftplus`, `all-in-one-wp-migration` | Backups and site migration utilities | Keep for WP rollback until cutover, not needed on Wix production | P1 |
| `envato-elements` | Asset/template helper | No direct equivalent needed post-rebuild | P2 |
| `file-manager-advanced`, `wp-file-manager` | File management in WP hosting | Not needed on Wix | P2 |

## Inactive or Suspicious Plugins (Cleanup Queue)

These should not be migrated and should be removed/archived on WP after cutover:
- `rjictthtcy/index` (inactive)
- `zvaykjtmtz/index` (inactive)
- `yikdlvultx/index` (inactive)
- `wrjglubnrt/index` (inactive)
- `dvcoqgunpp/index` (inactive)
- `dwluauvskb/index` (inactive)
- `bgozgyuikg/index` (inactive)
- `jdcguiffpx` directory present in files export but not in active plugin list

## Scope Decision Required

E-commerce is partially indicated by active WooCommerce stack and existing pages (`/cart`, `/checkout`, `/my-account`), but posts inventory is empty and product volume has not been confirmed in this repo yet.

Decision to confirm before Phase 4 build:
- Keep full commerce in Wix (`Wix Stores`) for launch, or
- Launch marketing/informational site first and defer commerce.

## Reference Links (Wix Docs)

- Wix Stores hub: https://support.wix.com/en/wix-stores
- Wix SEO page settings: https://support.wix.com/en/seo-page-settings
- Wix SEO defaults: https://support.wix.com/en/article/understanding-your-pages-default-seo-settings
- Wix Multilingual (manage languages): https://support.wix.com/en/article/wix-multilingual-managing-your-languages
- Wix Forms (multi-step setup): https://support.wix.com/en/article/wix-forms-adding-and-setting-up-a-multi-step-form
- Wix Automations overview: https://support.wix.com/en/article/wix-automations-about-the-new-automations-builder/
- Cookie banner on Wix (Usercentrics): https://support.wix.com/en/article/displaying-a-cookie-banner-on-your-site
