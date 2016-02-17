# Kerbal Save Sharing

A website for sharing Kerbal Space Program save files.
Primarily designed for a turn-based combat series.

Currently lacks basic features and is heavily work-in-progress.
Should be working in a week or so.

## Setup

1. Install prerequisites.
   (OpenResty, PostgreSQL, luarocks, moonscript, Lapis)
2. Setup database(s).
   (for production: `kss_live`, for development: `kss_dev`)
3. Create `secret.moon` with database password and a secret string.
   (see `secret.moon.example` for an example)
4. Compile moonscript files.
   (run `moonc .`)
5. Run migrations.
   (run `lapis migrate [env]` (env is `production` or `development`))
6. Start the server.
   (run `lapis server [env]` (same environments))
