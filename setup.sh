#!/bin/bash
if [ $EUID != 0 ]; then
        echo -e "Please run script as root user\n"
        exit 2
fi

apt update

cd /home/$SUDO_USER

apt install terminator -y

xfconf-query -c xfce4-keyboard-shortcuts -p "/commands/custom/<Primary>t" -n -t string -s "/usr/bin/terminator"

git clone https://github.com/dracula/terminator.git

./terminator/install.sh

curl -S https://raw.githubusercontent.com/gwalchmei151/tushar-personal-configs/refs/heads/main/terminator_config -o /home/$SUDO_USER/.config/terminator/config

curl -sS https://starship.rs/install.sh | sh

curl -S https://raw.githubusercontent.com/gwalchmei151/tushar-personal-configs/refs/heads/main/starship-pastel-w-timing-vienv.toml -o /home/$SUDO_USER/.config/starship.toml

apt install fastfetch -y

mkdir -p /home/$SUDO_USER/.config/fastfetch

curl -S https://raw.githubusercontent.com/gwalchmei151/tushar-personal-configs/refs/heads/main/config.jsonc -o /home/$SUDO_USER/.config/fastfetch/config.jsonc

rm /home/$SUDO_USER/.zshrc

curl -S https://raw.githubusercontent.com/gwalchmei151/tushar-personal-configs/refs/heads/main/.zshrc -o /home/$SUDO_USER/.zshrc

fastfetch -c /home/$SUDO_USER/.config/fastfetch/config.jsonc

xdotool key ctrl+t 
#sudo -u $SUDO_USER zsh -c "source ~/.zshrc"
