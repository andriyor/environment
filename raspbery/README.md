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


