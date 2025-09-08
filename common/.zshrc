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
source ~/aws-alias.zsh;
source ~/secrets.zsh;
source ~/os-specific.zsh;

eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
eval "$(sheldon source)"

# Console editor
export EDITOR=micro

# fnm
eval "$(fnm env --use-on-cd --shell zsh)"

# source "$HOME/.rye/env"
