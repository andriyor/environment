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
brew install git-delta

# dev
brew install redis
brew install nginx
brew install golang
# java
brew install temurin 

brew install --cask postman

# vm
brew install pyenv
brew install fnm

# code editor
brew install --cask sublime-text
brew install --cask visual-studio-code

# notes
brew install --cask obsidian
brew install --cask insync

# media
brew install --cask commander-one
brew install --cask spotify
brew install --cask obs
brew install --cask vlc
brew install --cask zoom

brew install stats
