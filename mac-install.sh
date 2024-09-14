/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

(echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> /Users/aoriekhov/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

# fonts
brew tap homebrew/cask-fonts
brew install --cask font-hack-nerd-font
brew install --cask font-fira-code

# keyboard
brew install --cask karabiner-elements

# VM
brew install --cask alt-tab

# terminal
curl -sS https://starship.rs/install.sh | sh
brew install iterm2
brew install --cask fig

brew install sheldon
sheldon init --shell zsh

# CLI tools
brew install bat
brew install eza
brew install micro
brew install jq
brew install difftastic
brew install gh
brew install awscli
brew install pipx

# dev
brew install redis
brew install nginx
brew install golang
brew install --cask switchhosts

# java
brew install temurin

brew install --cask postman
brew install --cask bruno

# vm
brew install pyenv
brew install fnm

# code editor
brew install --cask sublime-text
brew install --cask visual-studio-code
brew install --cask dbeaver-community

# notes
brew install --cask obsidian
brew install --cask insync

# media
brew install --cask commander-one
brew install --cask spotify
brew install --cask obs
brew install --cask vlc
brew install --cask zoom

# monitoring
brew install btop
brew install --cask stats
brew install --cask little-snitch
