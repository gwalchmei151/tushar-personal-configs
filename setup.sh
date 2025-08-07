#!/bin/bash

if [ "$EUID" -ne 0 ]; then
    echo -e "Please run script as root user\n"
    exit 2
fi

# Variables
USERNAME="$SUDO_USER"
USER_HOME="/home/$USERNAME"

# Update and install packages
apt update
apt install -y terminator fastfetch xdotool git curl

# Set Ctrl+T as shortcut for Terminator in XFCE
xfconf-query -c xfce4-keyboard-shortcuts -p "/commands/custom/<Primary>t" -n -t string -s "/usr/bin/terminator"

# Install Dracula theme for Terminator
cd "$USER_HOME"
sudo -u "$USERNAME" git clone https://github.com/dracula/terminator.git
sudo -u "$USERNAME" bash ./terminator/install.sh

# Ensure terminator config directory exists
mkdir -p "$USER_HOME/.config/terminator"
curl -sS https://raw.githubusercontent.com/gwalchmei151/tushar-personal-configs/refs/heads/main/terminator_config \
    -o "$USER_HOME/.config/terminator/config"

# Install Starship prompt
sudo -u "$USERNAME" sh -c 'curl -sS https://starship.rs/install.sh | sh'

# Set up Starship config
mkdir -p "$USER_HOME/.config"
curl -sS https://raw.githubusercontent.com/gwalchmei151/tushar-personal-configs/refs/heads/main/starship-pastel-w-timing-vienv.toml \
    -o "$USER_HOME/.config/starship.toml"

# Set up Fastfetch config
mkdir -p "$USER_HOME/.config/fastfetch"
curl -sS https://raw.githubusercontent.com/gwalchmei151/tushar-personal-configs/refs/heads/main/config.jsonc \
    -o "$USER_HOME/.config/fastfetch/config.jsonc"

# Replace .zshrc
rm -f "$USER_HOME/.zshrc"
curl -sS https://raw.githubusercontent.com/gwalchmei151/tushar-personal-configs/refs/heads/main/.zshrc \
    -o "$USER_HOME/.zshrc"

# Set correct ownership for all new files
chown -R "$USERNAME:$USERNAME" "$USER_HOME/.config" "$USER_HOME/.zshrc" "$USER_HOME/terminator"

# Run Fastfetch once for visual confirmation (optional)
sudo -u "$USERNAME" fastfetch -c "$USER_HOME/.config/fastfetch/config.jsonc"

# Simulate Ctrl+T to launch Terminator (optional, only works in GUI environment)
sudo -u "$USERNAME" xdotool key ctrl+t
