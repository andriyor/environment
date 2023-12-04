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
yay -S vlc # official repo ships newer version
yay -S spotify # aur repo ships newer version
flatpak install flathub org.flameshot.Flameshot
flatpak install flathub org.gnome.Loupe

# messengers/calls
flatpak install flathub org.telegram.desktop # tray icon on gnome works only in flatpack
snap install slack # snap ships new version
yay -S zoom # aur repo ships newer version

# dev
yay -S jetbrains-toolbox
snap install code --classic
snap install code-insiders --classic
sudo snap install sublime-text --classic 
yay -S nginx
yay -S redis
flatpak install flathub io.dbeaver.DBeaverCommunity

# docker
# https://docs.portainer.io/start/install-ce/server/docker/linux
docker volume create portainer_data
docker run -d -p 8000:8000 -p 9443:9443 --name portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:latest

# node
yay -S fnm-bin
curl -fsSL https://get.pnpm.io/install.sh | sh -

# python
yay -S pyenv

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
yay -S gnome-clocks
yay -S logiops

# notes/syncing
flatpak install flathub md.obsidian.Obsidian
yay -S insync # aur is single source

# gnome
yay -S gnome
yay -S gnome-browser-connector
yay -S gdm
systemctl enable gdm.service --force
flatpak install flathub com.mattjakeman.ExtensionManager
