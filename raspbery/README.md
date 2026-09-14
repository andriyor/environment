# Projects

## Personal

[Personal blog](https://github.com/andriyor/blog)

[Track channel messages based on keywords and receive notification from bot](https://github.com/andriyor/tele-track)

## Third party

[louislam/uptime-kuma: A fancy self-hosted monitoring tool](https://github.com/louislam/uptime-kuma)

[pi-hole/pi-hole: A black hole for Internet advertisements](https://github.com/pi-hole/pi-hole)


# Tools

## pm2

[Unitech/pm2: Node.js Production Process Manager with a built-in Load Balancer.](https://github.com/Unitech/pm2)

## docker

[docker/docker-install: Docker installation script](https://github.com/docker/docker-install)


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


# Raspberry Pi USB current cap

Two USB SSDs were tripping `over-current` and unmounting mid-copy. Fixed in
`/boot/firmware/config.txt` (reboot required):

```ini
usb_max_current_enable=1
```

Powering the Pi over the GPIO header (UPS HAT (E)) skips USB-C PD negotiation,
so firmware caps all USB ports at 600mA total; this raises it to 1.6A. Safe
here — the HAT draws only 14.5W during a dual-disk copy off a 19.5V PD brick.


