# environment

Personal dotfiles / homelab config repo. Goal: reproduce the user's environment on a new machine fast, and document daily-used tools.

## Layout

- `common/` — dotfiles shared across all machines (`.zshrc`, `.gitconfig`, `.claude/`, `.config/nvim`, `.config/karabiner`, etc.)
- `mac/` — macOS-only dotfiles and `Brewfile` (installed via `mac/mac-install.sh` + `brew bundle`)
- `linux/` — Linux-only dotfiles (includes `manjaro/`)
- `raspbery/` — homelab server config (docker-compose stacks, Pi boot config) — **not** stow-managed, deployed via `scp`/manual copy per `raspbery/install.sh`
- `example/` — scratch/sandbox JS, unrelated to environment setup

## Dotfile management: GNU Stow

Files under `common/`, `mac/`, and `linux/` mirror the target layout under `$HOME` and are symlinked into place with `stow` (config in `.stowrc`: `--target=$HOME`).

- Apply/update a package: `stow common` (or `mac`, `linux`) from repo root
- Re-stow after adding files: `stow -R common`
- Dry run: `stow -n -v common`
- To add a new tracked dotfile: move the real file from `$HOME` into the matching path under `common/` (or `mac/`/`linux/` if OS-specific), then `stow -R` the package so it symlinks back

## Secrets

`common/secrets.zsh` holds real API keys/tokens and is gitignored — never commit it or copy its contents into other tracked files. Other files in this repo (e.g. `common/.mcp.json`) should stay secret-free.

## Notes

- No test suite; `package.json` is just for a couple of Node deps used by scratch scripts in `example/`.
- `raspbery/` files with live secrets/config (`config.yaml`, `config.js`) are gitignored; only templates/docs are tracked.
