# Lamicke Yoga WP Remote CLI

This repo is configured to run WP-CLI commands against:

- `https://lamickeyoga.com/wp-json/` (via `wp-cli/restful`)

## 1. Setup

```bash
./scripts/setup-wp-cli.sh
cp .env.example .env
chmod +x ./wp ./scripts/setup-wp-cli.sh
```

Edit `.env` with:

- `WP_SITE_URL=https://lamickeyoga.com`
- `WP_ADMIN_USER=atemkeng`
- `WP_APP_PASSWORD=<recommended>`
- or `WP_ADMIN_PASSWORD=<fallback>`

## 2. Why application password is recommended

For authenticated REST actions, modern WordPress expects an **Application Password** (not your wp-admin login password) when using Basic Auth over REST.

Generate it here after logging in:

- `https://lamickeyoga.com/wp-admin/profile.php`

Then place it in `.env` as `WP_APP_PASSWORD`.
If WordPress shows the password in grouped blocks with spaces, you can paste it with or without spaces.

## 3. Run commands

List discovered REST resources:

```bash
./wp rest
```

List public pages:

```bash
./wp rest page list --per_page=5 --fields=id,title,link
```

Authenticated example (requires `WP_APP_PASSWORD`):

```bash
./wp rest user list --fields=id,slug,name --format=table
```
