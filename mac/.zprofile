eval "$(ssh-agent -s)"
# ssh-add

# -------------------------------------------------------
# clean version of  `eval "$(/opt/homebrew/bin/brew shellenv)"`
export HOMEBREW_PREFIX="/opt/homebrew";
export HOMEBREW_CELLAR="/opt/homebrew/Cellar";
export HOMEBREW_REPOSITORY="/opt/homebrew";
fpath[1,0]="/opt/homebrew/share/zsh/site-functions";

# Deduplicate and clean PATH
typeset -U path  # make PATH a unique array

# Rebuild PATH in clean order
path=(
  /opt/homebrew/bin
  /opt/homebrew/sbin
  /usr/bin
  /bin
  /sbin
  /usr/sbin
  /usr/local/bin
  /run/current-system/sw/bin
  $HOME/.bun/bin
  $HOME/.local/bin
  $HOME/Library/pnpm
  $HOME/.cargo/bin
  $HOME/go/bin
  ./node_modules/.bin
  /nix/var/nix/profiles/default/bin
)

[ -z "${MANPATH-}" ] || export MANPATH=":${MANPATH#:}";
export INFOPATH="/opt/homebrew/share/info:${INFOPATH:-}";
# -------------------------------------------------------

# # Setting PATH for Python 3.12
# # The original version is saved in .zprofile.pysave
# PATH="/Library/Frameworks/Python.framework/Versions/3.12/bin:${PATH}"
# export PATH

# # Setting PATH for Python 2.7
# # The original version is saved in .zprofile.pysave
# PATH="/Library/Frameworks/Python.framework/Versions/2.7/bin:${PATH}"
# export PATH
