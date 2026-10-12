#!/bin/bash
# Copy reusable Obsidian config from the vault into environment/obsidian
# plugin data.json files are skipped on purpose: excalidraw one contains API keys
rsync -a --delete-excluded --filter='P README.md' \
  --include='hotkeys.json' --include='appearance.json' \
  --include='core-plugins.json' --include='community-plugins.json' \
  --include='snippets/***' --exclude='*' \
  "$HOME/git/personal/md/.obsidian/" "$HOME/git/personal/environment/obsidian/"
