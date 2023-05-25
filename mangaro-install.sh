pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si

yay breeze-gtk

# browsers
yay google-chrome
yay google-chrome-dev

yay firefox
yay firefox-developer-edition

# media
yay vlc
yay spotify
yay flameshot

# messengers
yay telegram-desktop
snap install slack

# dev
yay jetbrains-toolbox
snap install code --classic
snap install code-insiders --classic

# node
curl -fsSL https://fnm.vercel.app/install | bash
curl -fsSL https://get.pnpm.io/install.sh | sh -

# terminal
yay tilix
brew install sheldon
yay jq
yay micro
yay bat
yay starship

# misc
yay krusader
yay blueman
yay redshift
