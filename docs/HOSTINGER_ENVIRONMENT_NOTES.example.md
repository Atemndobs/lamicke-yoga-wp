# Hostinger Environment Notes — Template

> The real `HOSTINGER_ENVIRONMENT_NOTES.md` is **not committed to git**.
> Atem will send it to you separately (encrypted message / password manager / 1Password share).
> Drop the received file at `docs/HOSTINGER_ENVIRONMENT_NOTES.md` — it is gitignored.

The file you receive will contain the following structure (values redacted here):

```
# Hostinger Environment Notes

## Account
- Hostinger email:      <redacted>
- Account / hPanel URL: <redacted>
- Hosting plan:         <redacted>

## hPanel access
- hPanel login:         <redacted>
- 2FA enabled:          yes / no

## Domain
- Primary domain:       lamickeyoga.com
- DNS provider:         <redacted>
- Nameservers:          <redacted>

## WordPress (current live site)
- WP admin URL:         https://lamickeyoga.com/wp-admin/
- WP admin user:        atemkeng
- WP admin password:    <redacted>     # see also .env WP_ADMIN_PASSWORD
- WP App Password:      <redacted>     # see also .env WP_APP_PASSWORD

## Database (Hostinger MySQL)
- DB host:              <redacted>
- DB name:              u766744182_t4nt4
- DB user:              <redacted>
- DB password:          <redacted>

## FTP / SFTP
- Host:                 <redacted>
- Port:                 <redacted>
- User:                 <redacted>
- Password:             <redacted>

## Hostinger API
- API token:            <redacted>
```

You only need this file if you intend to:
- Log into the live WordPress admin to verify content,
- Pull a fresh DB or files backup from Hostinger, or
- Re-run any WP-CLI/REST extraction against the live site.

For Wix-side build work (Phase 4), you do **not** need this file.
