scp ~/git/personal/environment/raspbery/cmdline.txt aoriekhov@192.168.0.162:/boot/firmware/cmdline.txt
scp ~/git/personal/environment/.config/micro/settings.json aoriekhov@192.168.0.162:/home/aoriekhov/.config/micro/settings.json

apt install micro
apt install bat

apt install sqlite3
curl -LsSf https://astral.sh/uv/install.sh | sh

# https://github.com/jesseduffield/lazygit
curl -Lo lazygit.tar.gz https://github.com/jesseduffield/lazygit/releases/download/v0.57.0/lazygit_0.57.0_linux_arm64.tar.gz
tar xf lazygit.tar.gz lazygit
sudo install lazygit -D -t /usr/local/bin/