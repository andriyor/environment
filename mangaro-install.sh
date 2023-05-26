pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si

yay -S breeze-gtk

# browsers
yay -S google-chrome
yay -S google-chrome-dev

yay -S firefox
yay -S firefox-developer-edition

# media
yay -S vlc
yay -S spotify
yay -S flameshot

# messengers
yay -S telegram-desktop
snap install slack

# dev
yay -S jetbrains-toolbox
snap install code --classic
snap install code-insiders --classic

# node
curl -fsSL https://fnm.vercel.app/install | bash
curl -fsSL https://get.pnpm.io/install.sh | sh -

# terminal
yay -S tilix
brew install sheldon
yay -S jq
yay -S micro
yay -S bat
yay -S starship
yay -S git-delta
yay -S fd

# misc
yay -S krusader
yay -S blueman
yay -S redshift
