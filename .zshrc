SAVEHIST=1000  # Save most-recent 1000 lines
HISTFILE=~/.zhistory

# pnpm
export PNPM_HOME="/home/andriy/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# fnm
export PATH="/home/andriy/.local/share/fnm:$PATH"
eval "`fnm env`"

alias rm="rm -i"

# fix this
eval `ssh-agent -s`

eval "$(sheldon source)"
