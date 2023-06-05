SAVEHIST=1000  # Save most-recent 1000 lines
HISTFILE=~/.zhistory

# What OS are we running?
if [[ $(uname) == "Darwin" ]]; then
  source ~/os/mac.zsh;
fi

eval "$(starship init zsh)"

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
redis-server --daemonize yes

eval "$(sheldon source)"

# Aliases
alias g='git'
alias cat='bat'
alias l='exa --all --icons'
alias ll='exa --long --all --git --icons'
alias ytdl="yt-dlp -f 'bestvideo[ext=mp4][vcodec!^=av0][vcodec!^=av1]+bestaudio[ext=m4a]/mp4/best' --recode-video mp4"

alias npmd='rm -rf ~/.npmrc'

alias ni='npm i --no-audit'
alias nu='npm uninstall'
alias ns='npm run start'
alias nt='npm run test'
alias nb='npm run build'

alias rmnm="find . -name 'node_modules' -type d -prune -exec rm -rf '{}' +"
alias rmbuild="find . -name 'build' -type d -prune -exec rm -rf '{}' +"

alias checklock1="jq '.dependencies[].resolved' package-lock.json | grep -v"
alias checklock2="jq '.packages[].resolved' package-lock.json | grep -v"

# Console editor
export EDITOR=micro
