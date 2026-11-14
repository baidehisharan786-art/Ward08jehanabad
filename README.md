# Ward 08 Jehanabad → Netlify migration starter

## Status: PARTIAL, NOT PRODUCTION READY

This is an independently created **read-only migration preview**, not a complete Floot export. It includes a Netlify deploy configuration, a basic Hindi development-works table, a server-side PostgreSQL query function, and reference schema definitions for public-facing tables. The original Floot Home page, styles, admin dashboard, authentication, uploads, and PDF functionality have NOT yet been migrated. Do not switch netajee.co.in DNS to this preview until all required features pass acceptance tests.

### Verified source
- Floot project: f4f32031-8a45-4ae1-aeb7-a579f33057d3 (255-file published release)
- Source: Floot connector inventory and the user's PostgreSQL SQL.gz dump dated 2026-11-14.
- Database: 13 tables; SQL dump was inspected locally. The original SQL dump is **intentionally excluded** from this package because it includes authentication, session and potentially personal data.

### Deploy a staging preview
1. Extract this ZIP, commit files to a **private** GitHub repository, and connect the repo to Netlify (or use Netlify CLI).
2. Netlify build command: `npm run build`; publish directory: `dist`. `netlify.toml` already supplies these.
3. Provision a private PostgreSQL database separately (e.g., Neon). Import the original backup securely **outside** your public repo. Avoid restoring active sessions, reset codes or password credentials without a deliberate auth migration. Review any personal information before import.
4. In Netlify **Site configuration → Environment variables**, set `DATABASE_URL` as a secret. Do not put it in source files or frontend code.
5. Redeploy and check `/api/works` and the preview table. No records are invented if the database is unavailable.
6. Validate all required features before setting the production domain.

### GoDaddy domain switch (ONLY after full migration)
1. Netlify → Domain management → Add `netajee.co.in` and `www.netajee.co.in`.
2. In GoDaddy Domain Portfolio → netajee.co.in → DNS, remove conflicting web forwarding and A/CNAME records only. Preserve MX, SPF, DKIM, DMARC and other email records.
3. Use the **exact apex A/ALIAS target and www CNAME** Netlify shows for your site. Netlify often uses `75.2.60.5` for apex A, but verify in your account.
4. Wait for DNS and HTTPS certificate issuance. Test both names and redirect preference.
5. Keep the original Floot deployment available until all checks pass.

### Missing work for full production parity
- Obtain or reconstruct all relevant Floot source files and build/runtime configuration
- Port all endpoints to Netlify Functions and replace Floot-only SDK APIs
- Migrate admin auth securely, roles, reset flows, rate limiting and session handling
- Migrate private and public media bytes (DB contains URLs, not necessarily file contents)
- Restore photo upload, editing, public service pages, PDF export, dashboard and all themes
- Run accessibility, security, functional and responsive regression tests
- Confirm database ownership, backups and costs

### Security
- The ZIP contains **no SQL dump, personal records, password hashes, session tokens, reset codes, or live secrets**.
- `database/public-tables-reference.sql` contains table definitions only, not an import-ready complete database schema.
- Keep the original SQL.gz backup private. It may contain citizen enquiries and account data.
