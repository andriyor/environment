#!/bin/bash
# Copy reusable Obsidian config from the vault into environment/obsidian
# Plugin settings (plugins/*/data.json) are not copied: they are vault-specific
# and already tracked in the vault repo.
rsync -a -m --delete-excluded --filter='P README.md' \
  --include='hotkeys.json' --include='appearance.json' \
  --include='core-plugins.json' --include='community-plugins.json' \
  --include='command-palette.json' \
  --include='snippets/***' \
  --exclude='*' \
  "$HOME/git/personal/md/.obsidian/" "$HOME/git/personal/environment/obsidian/"
