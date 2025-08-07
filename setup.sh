#!/bin/bash
if [ $EUID != 0 ]; then
        echo -e "Please run script as root user\n"
        exit 2
fi

apt update

curl -sS https://starship.rs/install.sh | sh

curl https://raw.githubusercontent.com/gwalchmei151/tushar-personal-configs/refs/heads/main/starship-pastel-w-timing-vienv.toml -o /home/$SUDO_USER/.config/starship.toml

apt install fastfetch

mkdir -p /home/$SUDO_USER/.config/fastfetch

curl -S https://raw.githubusercontent.com/gwalchmei151/tushar-personal-configs/refs/heads/main/config.jsonc -o /home/$SUDO_USER/.config/fastfetch/config.jsonc

rm /home/$SUDO_USER/.zshrc

curl https://raw.githubusercontent.com/gwalchmei151/tushar-personal-configs/refs/heads/main/.zshrc -o /home/$SUDO_USER/.zshrc

fastfetch -c /home/$SUDO_USER/.config/fastfetch/config.jsonc

sudo -u $SUDO_USER zsh -c "source ~/.zshrc"
