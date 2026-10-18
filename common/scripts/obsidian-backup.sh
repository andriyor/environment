#!/bin/bash
# Copy reusable Obsidian config from the vault into environment/obsidian
# Plugins whose data.json is not backed up:
#   obsidian-excalidraw-plugin  big and often updated
#   big-calendar                personal tags
#   life-tracker                personal health tracking
#   quickadd                    vault-specific choices
#   obsidian-icon-folder        icons keyed by vault folder paths
#   tasks-calendar-wrapper      vault-specific include paths and excluded properties
IGNORED_PLUGINS=(obsidian-excalidraw-plugin big-calendar life-tracker quickadd obsidian-icon-folder tasks-calendar-wrapper)

excludes=()
for p in "${IGNORED_PLUGINS[@]}"; do excludes+=(--exclude="plugins/$p/"); done

rsync -a -m --delete-excluded --filter='P README.md' \
  --include='hotkeys.json' --include='appearance.json' \
  --include='core-plugins.json' --include='community-plugins.json' \
  --include='snippets/***' \
  "${excludes[@]}" \
  --include='plugins/' --include='plugins/*/' --include='plugins/*/data.json' \
  --exclude='*' \
  "$HOME/git/personal/md/.obsidian/" "$HOME/git/personal/environment/obsidian/"
