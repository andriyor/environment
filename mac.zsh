# Fig post block. Keep at the bottom of this file.
[[ -f "$HOME/.fig/shell/zshrc.post.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.post.zsh"

alias subl='open -a "Sublime Text"'

# bun completions
[ -s "/Users/andrejorehov/.bun/_bun" ] && source "/Users/andrejorehov/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

bindkey "\e\eOD" backward-word
bindkey "\e\eOC" forward-word

# fnm
export PATH="/Users/andrejorehov/Library/Application Support/fnm:$PATH"
eval "`fnm env`"

# pnpm
export PNPM_HOME="/Users/aoriekhov/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
