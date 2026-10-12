# Obsidian

Backup of reusable config from vault `~/git/personal/md/.obsidian`: hotkeys, appearance, core/community plugin lists, CSS snippets.

Copied, not stowed: vault keeps real files so Obsidian Sync doesn't fight symlinks.

## Update

```shell
common/scripts/obsidian-backup.sh
```

Plugin `data.json` files skipped: excalidraw one contains API keys.

## Restore

```shell
rsync -a obsidian/ ~/git/personal/md/.obsidian/ --exclude README.md
```

Plugins themselves are not backed up, install them from community plugins after restore.
