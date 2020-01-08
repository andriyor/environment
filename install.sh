#!/bin/bash

sudo apt install xfce4-genmon-plugin
sudo apt install gnome-tweaks
# https://github.com/jonls/redshift#faq
sudo apt install redshift

sudo snap install chromium
sudo snap install firefox
# https://vivaldi.com/download/
# sudo snap install libreoffice
sudo snap install gimp
sudo snap install inkscape
sudo snap install vlc
sudo snap install spotify
sudo snap install musixmatch
sudo snap install telegram-desktop
sudo snap install skype --classic
# sudo snap install slack --classic
# https://github.com/lupoDharkael/flameshot#installation
sudo apt install flameshot
# https://fazlerabbi37.github.io/blogs/install_kde_connect_in_ubuntu_18.04.html
sudo apt install kdeconnect
# https://github.com/Genymobile/scrcpy#linux
sudo snap install scrcpy

# https://nomacs.org/download/
sudo add-apt-repository ppa:nomacs/stable
sudo apt update
sudo apt install nomacs

# https://software.opensuse.org/download.html?project=home%3AAlexx2000&package=doublecmd-gtk
sudo sh -c "echo 'deb http://download.opensuse.org/repositories/home:/Alexx2000/xUbuntu_19.10/ /' > /etc/apt/sources.list.d/home:Alexx2000.list"
wget -nv https://download.opensuse.org/repositories/home:Alexx2000/xUbuntu_19.10/Release.key -O Release.key
sudo apt-key add - < Release.key
sudo apt update
sudo apt install doublecmd-gtk

# https://www.dropbox.com/install-linux
cd ~ && wget -O - "https://www.dropbox.com/download?plat=lnx.x86_64" | tar xzf -
~/.dropbox-dist/dropboxd

sudo snap install dbeaver-ce
sudo snap install robo3t-snap
sudo snap install sublime-text --classic
sudo snap install code --classic
sudo snap install postman

# https://github.com/tonsky/FiraCode/wiki/Linux-instructions#installing-with-a-package-manager
sudo apt install fonts-firacode
# https://snwh.org/paper/download
sudo add-apt-repository -u ppa:snwh/ppa
sudo apt install paper-icon-theme

# https://www.jetbrains.com/toolbox-app/


# https://www.typora.io/#linux
wget -qO - https://typora.io/linux/public-key.asc | sudo apt-key add -
# add Typora's repository
sudo add-apt-repository 'deb https://typora.io/linux ./'
sudo apt update
# install typora
sudo apt install typora

# cli tools
# https://github.com/ohmyzsh/ohmyzsh/wiki/Installing-ZSH#ubuntu-debian--derivatives-windows-10-wsl--native-linux-kernel-with-windows-10-build-1903
sudo apt install zsh
# https://getantibody.github.io/install/
curl -sfL git.io/antibody | sh -s - -b /usr/local/bin
# https://github.com/BurntSushi/ripgrep#installation
sudo apt install ripgrep
# https://github.com/sharkdp/bat
sudo apt install bat

# brew
# https://docs.brew.sh/Homebrew-on-Linux
sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"
test -d ~/.linuxbrew && eval $(~/.linuxbrew/bin/brew shellenv)
test -d /home/linuxbrew/.linuxbrew && eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
test -r ~/.bash_profile && echo "eval \$($(brew --prefix)/bin/brew shellenv)" >>~/.bash_profile
echo "eval \$($(brew --prefix)/bin/brew shellenv)" >>~/.profile

# https://github.com/ogham/exa
brew install exa
# https://github.com/junegunn/fzf#using-homebrew-or-linuxbrew
brew install fzf
$(brew --prefix)/opt/fzf/install

# https://github.com/nvm-sh
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.2/install.sh | zsh
nvm install node

# https://yarnpkg.com/lang/en/docs/install/#debian-stable
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt update && sudo apt install yarn


# https://github.com/pyenv/pyenv-installer
curl https://pyenv.run | zsh
zsh
pyenv install 3.8.0
pyenv global 3.8.0
# https://github.com/python-poetry/poetry#installation
curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python
pip install --upgrade mackup

# https://docs.docker.com/install/linux/docker-ce/ubuntu/#install-using-the-repository
 sudo apt install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
sudo apt update
sudo apt install docker-ce docker-ce-cli containerd.io
docker run -it -p 8118:8118 -p 9055:9050 -d dperson/torproxy -l RU
