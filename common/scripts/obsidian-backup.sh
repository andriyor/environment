#!/bin/bash
# Copy reusable Obsidian config from the vault into environment/obsidian
# Plugin data.json skipped for: excalidraw (big and often updated), big-calendar (personal tags), life-tracker (personal health tracking)
rsync -a -m --delete-excluded --filter='P README.md' \
  --include='hotkeys.json' --include='appearance.json' \
  --include='core-plugins.json' --include='community-plugins.json' \
  --include='snippets/***' \
  --exclude='plugins/obsidian-excalidraw-plugin/' --exclude='plugins/big-calendar/' --exclude='plugins/life-tracker/' \
  --include='plugins/' --include='plugins/*/' --include='plugins/*/data.json' \
  --exclude='*' \
  "$HOME/git/personal/md/.obsidian/" "$HOME/git/personal/environment/obsidian/"
