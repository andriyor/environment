# Projects

## Personal

[Personal blog](https://github.com/andriyor/blog)

[Runway Budget: balances, runway and Monobank spending](https://github.com/andriyor/runway-budget)

[Archivegram: keep up with friends' Instagram stories](https://github.com/andriyor/archivegram)

[Track channel messages based on keywords and receive notification from bot](https://github.com/andriyor/tele-track)

## Third party

[louislam/uptime-kuma: A fancy self-hosted monitoring tool](https://github.com/louislam/uptime-kuma)

[pi-hole/pi-hole: A black hole for Internet advertisements](https://github.com/pi-hole/pi-hole)


# Tools

## pm2

[Unitech/pm2: Node.js Production Process Manager with a built-in Load Balancer.](https://github.com/Unitech/pm2)

## docker

[docker/docker-install: Docker installation script](https://github.com/docker/docker-install)


# Compose layout

`docker-compose.yml` only `include:`s the files in `stacks/` (home, media, arr,
network, monitoring, files, apps, tools), all as one `raspbery` project. Run
everything from this folder as before: `docker compose up -d`,
`docker compose pull radarr`.

- `project_directory: .` on each include keeps `./...` paths and `.env`
  relative to this folder, not `stacks/`. Don't run a stack file on its own
  with `-f` for `up` — it would resolve paths and the project name from
  `stacks/`.
- Act on one stack by its service list:
  `docker compose pull $(docker compose -f stacks/arr.yml config --services)`.
- `stacks/unused/` holds standalone stacks not in use (elastic, kafka,
  monitoring, nextcloud, and `misc.yml` with kavita, seerr, nocodb, portainer,
  open-webui, fladder), not included. Run one with `docker compose -f stacks/unused/kafka.yml up -d`;
  its project is then named `unused`, so pass `-p raspbery` to reuse the old
  `raspbery_*` volumes (it will warn about orphans — never add
  `--remove-orphans` there, it would stop the whole main stack).

## Healthchecks

Only images that ship their own `HEALTHCHECK` have one (jellyfin, firefly,
karakeep, keepard, filebrowser, nextexplorer, shelfmark, mtproto-proxy), plus
`keepard-db` because `keepard` waits on it with `condition: service_healthy`.
Adding one to every service was tried and reverted (Nov 2026):

- Nothing acts on "unhealthy": `restart: unless-stopped` only restarts when the
  process exits, there's no autoheal, and Gatus checks only external endpoints.
- Every probe is an `exec` every 30s, and Docker writes each result to
  `/var/lib/docker`, which is on the SD card (the I/O bottleneck).

Add one per service only with a consumer: a `depends_on: service_healthy`, or
an autoheal container for something that hangs without exiting. For "is it
down?" alerts, add the service to Gatus (`config.yaml`) instead. The probes
were verified working, if needed again:

| Service | Probe |
| --- | --- |
| prowlarr / radarr / lidarr / whisparr | `curl -fsS http://localhost:<port>/ping` |
| bazarr | `curl -fsS http://localhost:6767/api/system/ping` |
| flaresolverr / influxdb / meilisearch | `curl -fsS http://localhost:<port>/health` |
| grafana | `wget -qO /dev/null http://localhost:3000/api/health` |
| homeassistant | `curl -fsS http://localhost:8123/manifest.json` (give it `start_period: 2m`) |
| matter-server | `curl -sS -o /dev/null http://localhost:5580/` (websocket, any response = up) |
| stash | `wget -qO /dev/null http://localhost:9999/healthz` |
| ezbookkeeping | `wget -qO /dev/null http://localhost:8080/healthz.json` |
| adguardhome | `wget -qO /dev/null http://127.0.0.1:80/login.html` |
| toggl-wrapper | `wget ... http://127.0.0.1:5173/` (vite is IPv4-only, not `localhost`) |
| toggl-lock | `nc -z 127.0.0.1 8790` (no GET route, `/` is 404) |
| runway | `node -e "fetch('http://127.0.0.1:3000/')..."` (no curl/wget) |
| archivegram / airtable-wrapper | `python3 -c "import urllib.request as u; u.urlopen(...)"` |
| blog | `bash -c 'exec 3<>/dev/tcp/127.0.0.1/80'` (httpd, no curl/wget) |
| beszel / beszel-agent | `/beszel health --url http://localhost:8090`, `/agent health` (distroless) |
| gatus | none possible: scratch image, no shell, no health subcommand |

# FileBrowser Quantum

[gtsteffaniak/filebrowser](https://github.com/gtsteffaniak/filebrowser) on 9090,
replaced the original `filebrowser/filebrowser`.

- `filebrowser/config.yaml` is mandatory — exits FATAL without it.
- With more than one source, each needs `defaultEnabled: true`, else
  `500 user has no access to source`.
- `viewable: true` on the `pi` source disables indexing of `/`: still fully
  browsable and writable, but no search and no recursive folder sizes.


# Securo

[securo-finance/securo: self-hosted personal finance manager](https://github.com/securo-finance/securo)

Ships its own compose stack (postgres + redis + backend + frontend + 2 celery
workers), so it is **not** in `docker-compose.yml`. It runs from an upstream
clone outside this repo, at `~/apps/securo`:

```bash
git clone https://github.com/securo-finance/securo.git ~/apps/securo
cd ~/apps/securo
cp .env.example .env
docker compose -f docker-compose.prod.yml up -d
```

Use `docker-compose.prod.yml`, not the bare `docker compose up` from the
upstream quick start — the repo-root `docker-compose.yml` is the dev stack
(`build: ./backend`, frontend via `Dockerfile.dev` on Vite) and would compile
from source on ARM. The prod file uses prebuilt `ghcr.io` images and runs
migrations on boot. This is what upstream's own `install.sh` does.

Local `.env` deviations from `.env.example` (it is gitignored upstream):

- `SECRET_KEY` — generated with `openssl rand -hex 32`
- `FRONTEND_PORT=3001`, `BACKEND_PORT=8001` — 3000 is grafana, 8000 is
  airtable-wrapper
- `FRONTEND_URL=http://192.168.0.162:3001` — drives CORS and OAuth callbacks,
  must match how the app is opened

Passkeys will not work on this URL: WebAuthn forbids both bare IPs and plain
HTTP (except `localhost`). Needs a domain over HTTPS behind a reverse proxy.
Password login is unaffected.

Update with `git -C ~/apps/securo pull && docker compose -f
docker-compose.prod.yml up -d --pull always`. Migrations run automatically on
backend start, so snapshot the `securo_pgdata` volume first.


# Keepard

[sars/keepard](https://github.com/sars/keepard): self-hosted spending tracker
that imports monobank through its personal API. In `stacks/finance.yml`:
`keepard-db` (postgres), `keepard` (dashboard, built from the `lan-hosts`
branch of my fork [andriyor/keepard](https://github.com/andriyor/keepard/tree/lan-hosts),
compiled on the Pi) and `keepard-sync`, a loop that replaces upstream's systemd
timers. Upstream's `compose.yaml` and `/opt` + `/etc/private-finances` layout
are not used: `./keepard/config` is mounted as `/etc/private-finances`.

One-time setup, from this folder on the Pi:

```bash
install -d -m 755 keepard/config keepard/state
install -d -m 700 keepard/config/credentials keepard/state/consent keepard/state/sync
sudo install -d -m 755 -o root -g root keepard/config/schedules
```

`keepard/config/db.env` (mode 600), with `openssl rand -hex 32`:

```ini
POSTGRES_PASSWORD=<generated>
```

`keepard/config/app.env` (mode 600), the same password in `DATABASE_URL`, host
`keepard-db`. Keepard requires exactly two members; member 2 is a dummy that
never signs in and has no bank token. Passwords at least 20 characters
(`openssl rand -hex 24`), applied at every start; there is no reset by email.

```ini
DATABASE_URL=postgresql://private-finances:<generated>@keepard-db:5432/private_finances
MEMBER_1_NAME=Andrii
MEMBER_1_EMAIL=<my email>
MEMBER_1_PASSWORD=<generated>
MEMBER_2_NAME=Nobody
MEMBER_2_EMAIL=<any other address>
MEMBER_2_PASSWORD=<generated>
LAN_HOSTS=192.168.1.65:3300
```

A password with `$` must be in single quotes (`MEMBER_1_PASSWORD='...'`), or
Compose reads `$...` as a variable and cuts it.

monobank token from [api.monobank.ua](https://api.monobank.ua/). The file name
is fixed (`rodion` is keepard's internal key for member 1), owned by the
container user (`KEEPARD_UID`, default 1000 = `id -u`), mode 600:

```bash
read -rsp "Token: " v; echo; umask 077
printf "%s\n" "$v" > keepard/config/credentials/monobank-rodion-token; unset v
```

Turn imports on. The scheduler only trusts markers owned by root and not
group/other-writable, so these are written with sudo:

```bash
echo local-restore-verified | sudo tee keepard/config/local-restore-verified >/dev/null
echo monobank-rodion | sudo tee keepard/config/schedules/monobank-rodion.enabled >/dev/null
sudo chmod 644 keepard/config/local-restore-verified keepard/config/schedules/monobank-rodion.enabled
```

Start: `docker compose up -d --build keepard keepard-db keepard-sync`. The
first build compiles TypeScript on the Pi and takes a while.

Open http://192.168.1.65:3300. Upstream accepts only Host `localhost:3300` or
an HTTPS `PUBLIC_ORIGIN` and always sends a `Secure` session cookie; the fork's
`LAN_HOSTS` adds that address and drops `Secure` for it. Plain HTTP: password
and session cross the Wi-Fi unencrypted, and the iPhone home-screen install
still needs HTTPS. Without `LAN_HOSTS`: `ssh -L 3300:localhost:3300 rp`, then
http://localhost:3300.

A run killed mid-import (e.g. recreating `keepard-sync`) leaves a
`keepard/state/sync/monobank-rodion.blocked` latch, and later runs log
`"result":"blocked"`. Leave it: after 10 minutes the scheduler sees the attempt
still `running` with no live lease and retries by itself, or press "Retry import"
on Bank connections. Don't mark the attempt failed in the database or delete the
latch by hand — that hides the evidence the auto-recovery looks for
([docs/scheduling.md](https://github.com/sars/keepard/blob/main/docs/scheduling.md)).

Previous years, once (monobank allows one request a minute, so pause the loop):

```bash
docker compose stop keepard-sync
docker compose run --rm keepard-sync node dist/src/backfill-cli.js monobank rodion 2020-01-01 2026-11-04
docker compose start keepard-sync
```

Logs: `docker compose logs -f keepard-sync`; `"result":"disabled"` means a
marker above is missing or not root-owned.


# Firefly III

[firefly-iii](https://github.com/firefly-iii/firefly-iii) on http://192.168.1.65:8085,
in `stacks/finance.yml`. The image is the release `fireflyiii/core:version-6.7.9`
with 3 files of my dashboard currency switcher
([andriyor/firefly-iii `currency-switch`](https://github.com/andriyor/firefly-iii/tree/currency-switch),
issue firefly-iii#13160) downloaded over it, so nothing is compiled on the Pi.
Before bumping the tag, rebase the branch onto it. SQLite in the
`firefly-database` volume, no separate database container. `firefly-cron` calls
the cron endpoint daily at 03:00 (recurring transactions, exchange rates).

One-time setup, from this folder on the Pi. `firefly/` is gitignored and is
also the build context:

```bash
install -d -m 700 firefly
umask 077
cat > firefly/.env <<EOF
APP_ENV=production
APP_KEY=$(openssl rand -hex 16)
STATIC_CRON_TOKEN=$(openssl rand -hex 16)
APP_URL=http://192.168.1.65:8085
SITE_OWNER=<my email>
TZ=Europe/Kyiv
DEFAULT_LANGUAGE=en_US
DB_CONNECTION=sqlite
ENABLE_EXCHANGE_RATES=true
ENABLE_EXTERNAL_RATES=true
EOF
docker compose up -d --build firefly firefly-cron
```

`APP_KEY` encrypts data: keep it, a new one makes the database unreadable.
Open the URL and register; the first account is the admin.

Update the switcher after pushing to the branch:
`docker compose build --no-cache firefly && docker compose up -d firefly`.


# Runway Budget

[andriyor/runway-budget](https://github.com/andriyor/runway-budget) on http://192.168.1.65:8087,
in `stacks/apps.yml`: `runway-api` (Fastify, SQLite in `./runway-budget/data`) and `runway-web`
(nginx, proxies `/api` to the API), both built on the Pi from `main`. The API syncs one Monobank
card at 09:00 and 21:00 Kyiv time (`TZ=Europe/Kyiv`).

One-time setup, from this folder on the Pi. `runway-budget/` is gitignored:

```bash
install -d -m 700 runway-budget runway-budget/data
umask 077
cat > runway-budget/.env <<EOF
MONO_TOKEN=<personal token from api.monobank.ua>
MONO_ACCOUNT=<card account id from /personal/client-info>
EOF
docker compose up -d --build runway-api runway-web
```

The database is created on first start. To move an existing one, copy it to
`runway-budget/data/data.db` before starting (`sqlite3 data.db ".backup copy.db"` makes a safe
copy of a database in use). Older history: one sync per earlier 31-day window, a minute apart,
e.g. `curl -X POST "localhost:8087/api/accounts/mono/sync?to=$(date -d '-31 days' +%s)"`.

Update after pushing to `main`: `docker compose up -d --build runway-api runway-web`.

# Archivegram

[andriyor/archivegram](https://github.com/andriyor/archivegram) (private) on http://192.168.1.65:8088,
in `stacks/apps.yml`: one container, the FastAPI API serving the built web app. It downloads the
current stories of all subscribed profiles about every 6 hours (`DOWNLOAD_INTERVAL_HOURS`), stories
grouped by Kyiv day (`TZ=Europe/Kyiv`). The repo is private, so it is built from a clone in
`archivegram/src` rather than a git URL. `archivegram/` is gitignored.

One-time setup, from this folder on the Pi. The Instagram session comes from a machine where you
logged in with Instaloader (`~/.config/instaloader/session-<account>`, see the Archivegram README):

```bash
install -d -m 700 archivegram archivegram/instaloader
git clone https://github.com/andriyor/archivegram.git archivegram/src
mkdir -p archivegram/data  # or copy an existing api/data here
echo "INSTAGRAM_USERNAME=<account>" > archivegram/.env && chmod 600 archivegram/.env
scp <machine>:.config/instaloader/session-<account> archivegram/instaloader/
docker compose up -d --build archivegram
```

Update after pushing to `master`: `git -C archivegram/src pull && docker compose up -d --build archivegram`.

Run only one instance per Instagram account: two would download with the same session and double
the requests Instagram sees.

# Raspotify

[dtcooper/raspotify](https://github.com/dtcooper/raspotify) (apt package,
Spotify Connect via librespot) on the IQaudIO DAC. Settings are in
`raspotify.conf` here, not `/etc/raspotify/conf`: a systemd drop-in
(`/etc/systemd/system/raspotify.service.d/override.conf`, set up by
`install.sh`) clears the package's `EnvironmentFile` and points it at this
file. systemd reads it before sandboxing, so `ProtectHome=true` doesn't block
it, and package upgrades never touch it. After editing:
`sudo systemctl restart raspotify`.


# Raspberry Pi I2C

The Waveshare UPS HAT talks over the Pi's hardware I2C bus (`i2c-1`). Enable it
in `/boot/firmware/config.txt` (older images: `/boot/config.txt`):

```ini
dtparam=i2c_arm=on
dtparam=i2c_arm_baudrate=50000
```

- `dtparam=i2c_arm=on` enables the ARM I2C controller, creating `/dev/i2c-1`.
  Without it the UPS HAT cannot be read.
- `dtparam=i2c_arm_baudrate=50000` lowers the bus clock to 50 kHz (default is
  100 kHz). The UPS HAT (E) MCU at `0x2d` is slow to respond and NAKs reads
  while busy, surfacing as `OSError(121) "Remote I/O error"` and sometimes
  wedging the bus (SDA stuck low). Running slower makes reads far more reliable.

Reboot after editing, then verify: `i2cdetect -y 1` (UPS HAT (E) shows at
`0x2d`, INA219-based HATs at `0x42`).

Home Assistant reads it via the `waveshare_ups_hat` integration from my fork
[andriyor/hacs_waveshare_ups_hat](https://github.com/andriyor/hacs_waveshare_ups_hat)
(adds UPS HAT (E) support, `ups_hat_e.py`; upstream mykhailog's only handles
INA219 HATs). Install it in HACS as a custom repository pointing at the fork,
not the upstream one.


# Raspberry Pi USB current cap

Two USB SSDs were tripping `over-current` and unmounting mid-copy. Fixed in
`/boot/firmware/config.txt` (reboot required):

```ini
usb_max_current_enable=1
```

Powering the Pi over the GPIO header (UPS HAT (E)) skips USB-C PD negotiation,
so firmware caps all USB ports at 600mA total; this raises it to 1.6A. Safe
here — the HAT draws only 14.5W during a dual-disk copy off a 19.5V PD brick.


# Router (Synology SRM)

Synology SRM at `192.168.1.1`, UI at `http://192.168.1.1:8000`. The WAN IP is
public (no CGNAT), so port forwards work. The Pi (eth0 `2c:cf:67:87:8d:c2`) has
a DHCP reservation for `192.168.1.65`.

Port forwards:

| Name | Port | Protocol | Target |
|---|---|---|---|
| qbittorrent | 6881 → 6881 | TCP+UDP | 192.168.1.65 |

Without the 6881 forward, qBittorrent can still download from seeders that
accept incoming connections, but torrents whose few seeders are also firewalled
never connect. UPnP is enabled on the router, but qBittorrent's UPnP can't help:
the container runs on a Docker bridge, so it would map to its `172.18.x` address.

Check whether the forward works from the Pi (needs NAT loopback, which SRM does):
`timeout 5 bash -c '</dev/tcp/<WAN IP>/6881' && echo open`.

## SRM web API

Changes can be made from the Pi without a browser:

- Login: POST `http://192.168.1.1:8000/webapi/auth.cgi` with
  `api=SYNO.API.Auth&version=3&method=login&account=…&passwd=…&session=webui&format=sid&enable_syno_token=yes`.
  It returns `sid` and `synotoken`.
- Calls: POST `/webapi/_______________________________________________________entry.cgi`
  (yes, that many underscores) with `api`, `method`, `version`, `_sid`,
  `SynoToken`, and each parameter JSON-encoded.
- `GET /webapi/query.cgi?api=SYNO.API.Info&version=1&method=query&query=all`
  lists every API (no login needed).
- Port forwards: `SYNO.Core.Network.Router.PortForward` v1, `get` / `set`.
  `set` takes `rules=[…]` and **replaces the whole list**, so always send the
  existing rules plus the new one. A rule is
  `{"id":0,"enabled":true,"service":"qbittorrent","sourcePort":"6881","targetIP":"192.168.1.65","targetPort":"6881","protocol":"all"}`.
  `protocol` must be `tcp`, `udp` or `all` (TCP+UDP); anything else returns HTTP 500.
- DHCP reservations: `SYNO.Core.Network.DHCPServer.Reservation` v2 `get`
  with `ifname="lbr0"`.
- Field names for other settings come from the UI code:
  `/webman/modules/nsm-Home/NSMHome.js` (fetch with cookie `id=<sid>`).


