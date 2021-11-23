#!/bin/bash

############################################################################################################################################

# Fedora sway installer sysoply.pl Paweł Pietryszak 2021

############################################################################################################################################

# Sway
sudo dnf install -y sway 

# Wl-clipboard
#sudo dnf install -y wl-clipboard

# Waybar
sudo dnf install -y waybar

# Kanshi
sudo dnf install -y kanshi 
 
# Sway info for windows classes
pip install --user swaytools  

# Install foot terminal
sudo dnf install -y foot

# Grimshot - sway screenshot tool
sudo dnf install -y grimshot
mkdir -p $HOME/Pictures/screenshots
echo 'XDG_SCREENSHOTS_DIR="$HOME/Pictures/screenshots"' | sudo tee -a ~/.config/user-dirs.dirs

# Copy sway config to proper folder
\cp -r ~/.gc/dotfiles/sway ~/.config

# Copy foot terminal config to to proper folder
\cp -r ~/.gc/dotfiles/foot ~/.config
