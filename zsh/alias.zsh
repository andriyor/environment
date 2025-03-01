# Aliases
alias g='git'
alias gl="git pull && (git diff --name-only HEAD@{1} HEAD | grep -qE 'package(-lock)?\.json' && ni || echo 'No dependency changes detected')"

alias cat='bat'
alias l='eza --all --icons'
alias ll='eza --long --all --git --icons'
alias ytdl="yt-dlp -f 'bestvideo[ext=mp4][vcodec!^=av0][vcodec!^=av1]+bestaudio[ext=m4a]/mp4/best' --recode-video mp4"

alias npmd='rm -rf ~/.npmrc'

# alias ni='npm i --no-audit'
alias nsb='npm run storybook'
alias nu='npm uninstall'
alias ns='npm run start'
alias nt='npm run test'
alias nb='npm run build'
alias nr='npm run'
alias nrl='npm run lint'
alias nrt='npm run typecheck'

alias nrcw='rm ~/.npmrc;ln -s ~/git/work/.npmrc ~/.npmrc'
alias nrcp='rm ~/.npmrc;ln -s ~/git/personal/.npmrc ~/.npmrc'

alias pi='pnpm i'

alias nts='node --import=tsimp/import'

alias rmnm="find . -name 'node_modules' -type d -prune -exec rm -rf '{}' +"
alias rmbuild="find . -name 'build' -type d -prune -exec rm -rf '{}' +"

alias checklock1="jq '.dependencies[].resolved' package-lock.json | grep -v"
alias checklock2="jq '.packages[].resolved' package-lock.json | grep -v"

# process memory `psmem 20128`
alias psmem='function _psmem() { ps -o rss= -p $(pgrep -g $1) | awk "{sum += \$1} END {print sum / 1048576 \" GB\"}"; }; _psmem'

# top files by line count
alias tl='f() { [ -z "$1" ] && echo "Usage: fmd <extension>" && return; find . -type f -name "*.$1" -print0 | xargs -0 wc -l | sort -nr | head -n 10; }; f'
