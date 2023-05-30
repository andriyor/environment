pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si

yay -S breeze-gtk

# browsers
yay -S google-chrome
yay -S google-chrome-dev

yay -S firefox
yay -S firefox-developer-edition

# video
yay -S intel-media-driver
yay -S libva-utils
yay -S mpv

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
yay -S nginx
yay -S redis

# node
curl -fsSL https://fnm.vercel.app/install | bash
curl -fsSL https://get.pnpm.io/install.sh | sh -

# terminal
yay -S tilix
brew install sheldon
yay -S starship
yay -S micro
yay -S bat
yay -S exa
yay -S git-delta
yay -S fd
yay -S jq
yay -S yt-dlp

# misc
yay -S krusader
yay -S blueman
yay -S redshift
