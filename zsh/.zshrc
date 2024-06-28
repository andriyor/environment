# Fig pre block. Keep at the top of this file.
[[ -f "$HOME/.fig/shell/zshrc.pre.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.pre.zsh"

# https://jdhao.github.io/2021/03/24/zsh_history_setup/
# history setup
HISTFILE=$HOME/.zsh_history
export HISTSIZE=1000000   # the number of items for the internal history list
export SAVEHIST=1000000   # maximum number of items for the history file

# The meaning of these options can be found in man page of `zshoptions`.
setopt HIST_IGNORE_ALL_DUPS  # do not put duplicated command into history list
setopt HIST_SAVE_NO_DUPS  # do not save duplicated command
setopt HIST_REDUCE_BLANKS  # remove unnecessary blanks
setopt INC_APPEND_HISTORY_TIME  # append command to history file immediately after execution
setopt EXTENDED_HISTORY  # record command start time
setopt SHARE_HISTORY


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
eval "$(pyenv init --path)"

# fnm
eval "$(fnm env --use-on-cd)"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

export NIX_INSTALL="$HOME/.nix-profile"
export PATH="$NIX_INSTALL/bin:$PATH"

# Fig post block. Keep at the bottom of this file.
[[ -f "$HOME/.fig/shell/zshrc.post.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.post.zsh"
