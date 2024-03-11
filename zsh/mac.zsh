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

# golang
export GOROOT="/opt/homebrew/bin/go"
export GOPATH="$HOME/go"
export PATH="$GOPATH/bin:$GOROOT/bin:$PATH"


[[ "$TERM_PROGRAM" == "CodeEditApp_Terminal" ]] && . "/Applications/CodeEdit.app/Contents/Resources/codeedit_shell_integration.zsh"
