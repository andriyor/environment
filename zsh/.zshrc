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

source ~/alias.zsh;

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

# Console editor
export EDITOR=micro

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# fnm
eval "$(fnm env --use-on-cd)"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

export NIX_INSTALL="$HOME/.nix-profile"
export PATH="$NIX_INSTALL/bin:$PATH"

# Fig post block. Keep at the bottom of this file.
[[ -f "$HOME/.fig/shell/zshrc.post.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.post.zsh"
