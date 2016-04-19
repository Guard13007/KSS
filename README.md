# Kerbal Warfare

A website for managing a turn-based warfare game in Kerbal Space Program.

Very work-in-progress, but functional.

## Setup (Overview)

1. Install prerequisites.
   (OpenResty, PostgreSQL, luarocks, moonscript, Lapis, LPeg)
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
   (run `lapis server [env]` (env is `production` or `development`))
8. Log into the default admin account and change its password.
   (username: `admin`, password `changeme`)

## Setup (Detailed Steps)

These instructions assume you are setting up a development and production
environment. Feel free to skip any steps not necessary for one or the other if
you are not.

1. Install prerequisites for prerequisites:
   `sudo apt-get install git lua5.1 liblua5.1-0-dev unzip libreadline-dev libncurses5-dev libpcre3-dev libssl-dev perl make build-essential postgres`
2. Install LuaRocks and OpenResty:
   ```bash
   # OpenResty
   wget https://openresty.org/download/openresty-1.9.7.4.tar.gz # check for and install a later version if available!
   tar xvf openresty-1.9.7.4.tar.gz
   cd openresty-1.9.7.4.tar.gz
   ./configure
   make
   sudo make install
   # LuaRocks
   wget https://keplerproject.github.io/luarocks/releases/luarocks-2.3.0.tar.gz # check for and install a later version if available!
   tar xvf luarocks-2.3.0.tar.gz
   cd luarocks-2.3.0.tar.gz
   ./configure
   make build
   sudo make install
   ```
3. Install rocks:
   `sudo luarocks install lapis moonscript lpeg lunamark`
4. Set your PostgreSQL password, setup databases:
   ```bash
   # change user: su - postgres [OR] sudo -i -u postgres
   psql
   ALTER USER postgres WITH PASSWORD 'password';
   \q
   createdb kss_live
   createdb kss_dev
   exit
   ```
5. Clone repository and set up `secret.moon`:
   ```
   git clone https://github.com/Guard13007/KSS.git
   cp secret.moon.example secret.moon
   nano secret.moon   # or your editor of choice
   ```
6. Put SSL certificate and private key in `ssl/`:
   ```bash
   # I recommend installing Let's Encrypt: https://letsencrypt.org/getting-started/
   # Get it from your package manager or:
   git clone https://github.com/letsencrypt/letsencrypt
   cd letsencrypt
   # generate your certificate (do not have anything running on port 80!)
   ./letsencrypt-auto certonly --standalone -d domain.name -d dev.domain.name
   ln -s /etc/letsencrypt/live/domain.name/fullchain.pem ./ssl/fullchain.pem
   ln -s /etc/letsencrypt/live/domain.name/privkey.pem ./ssl/privkey.pem
   # now you can easily renew certificates:
   # letsencrypt renew [OR] ./letsencrypt-auto renew
   ```
7. Set up proxy server on port 80:
   TODO: Write this.
8. Compile moonscript and run migrations/server:
   ```bash
   moonc .
   lapis migrate development # use production instead of development for production server
   lapis server development  # note: will stay open, consider using screen or another terminal to run it
   ```

Additionally, if you are using Chrome and a self-signed certificate, [this][1]
might be helpful.

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

[1]: https://stackoverflow.com/questions/7580508/getting-chrome-to-accept-self-signed-localhost-certificate
