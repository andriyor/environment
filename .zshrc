# Fig pre block. Keep at the top of this file.
[[ -f "$HOME/.fig/shell/zshrc.pre.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.pre.zsh"
# history setup
setopt APPEND_HISTORY
setopt SHARE_HISTORY
HISTFILE=$HOME/.zsh_history
SAVEHIST=1000
HISTSIZE=999
setopt HIST_EXPIRE_DUPS_FIRST
setopt EXTENDED_HISTORY

# autocompletion using arrow keys (based on history)
bindkey '\e[A' history-search-backward
bindkey '\e[B' history-search-forward

# What OS are we running?
if [[ $(uname) == "Darwin" ]]; then
  source ~/os/mac.zsh;
fi

if [[ $(uname) == "Linux" ]]; then
  source ~/os/linux.zsh;
fi

eval "$(starship init zsh)"

export PATH="$PATH:./node_modules/.bin"

# save rm
# alias rm="rm -i"

# fix this
eval `ssh-agent`
# ssh-add

redis-server --daemonize yes

eval "$(sheldon source)"

# Aliases
alias g='git'
alias cat='bat'
alias l='eza --all --icons'
alias ll='eza --long --all --git --icons'
alias ytdl="yt-dlp -f 'bestvideo[ext=mp4][vcodec!^=av0][vcodec!^=av1]+bestaudio[ext=m4a]/mp4/best' --recode-video mp4"

alias npmd='rm -rf ~/.npmrc'

alias ni='npm i --no-audit'
alias nsb='npm run storybook'
alias nu='npm uninstall'
alias ns='npm run start'
alias nt='npm run test'
alias nb='npm run build'
alias nr='npm run'
alias nrl='npm run lint'
alias nrt='npm run typecheck'
alias pi='pnpm i'

alias nts='node --import=tsimp/import'

alias rmnm="find . -name 'node_modules' -type d -prune -exec rm -rf '{}' +"
alias rmbuild="find . -name 'build' -type d -prune -exec rm -rf '{}' +"

alias checklock1="jq '.dependencies[].resolved' package-lock.json | grep -v"
alias checklock2="jq '.packages[].resolved' package-lock.json | grep -v"

# Console editor
export EDITOR=micro

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# fnm
eval "$(fnm env --use-on-cd)"

# bun completions
[ -s "/home/andriy/.bun/_bun" ] && source "/home/andriy/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

export NIX_INSTALL="$HOME/.nix-profile"
export PATH="$NIX_INSTALL/bin:$PATH"

[ -f ~/.inshellisense/key-bindings.zsh ] && source ~/.inshellisense/key-bindings.zsh

# Fig post block. Keep at the bottom of this file.
[[ -f "$HOME/.fig/shell/zshrc.post.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.post.zsh"

[[ "$TERM_PROGRAM" == "CodeEditApp_Terminal" ]] && . "/Applications/CodeEdit.app/Contents/Resources/codeedit_shell_integration.zsh"
