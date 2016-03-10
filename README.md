# Kerbal Warfare

A website for managing a turn-based warfare game in Kerbal Space Program.

Very work-in-progress, but functional.

## Setup

1. Install prerequisites.
   (OpenResty, PostgreSQL, luarocks, moonscript, Lapis)
2. Setup database(s).
   (for production: `kss_live`, for development: `kss_dev`)
3. Create `secret.moon` with database password and a secret string.
   (see `secret.moon.example` for an example)
4. Place SSL certificate in `ssl/`.
   (public: `fullchain.pem`, private: `privkey.pem`)
5. Compile moonscript files.
   (run `moonc .`)
6. Run migrations.
   (run `lapis migrate [env]` (env is `production` or `development`))
7. Start the server.
   (run `lapis server [env]` (same environments))
8. Log into the default admin account and change its password.
   (username: `admin`, password `changeme`)

### Note to self

If you fuck up and lose the `postgres` password...

```
sudo -i -u postgres
psql
ALTER USER postgres WITH PASSWORD 'new_password';
\q
exit
```

And now it's fixed.
