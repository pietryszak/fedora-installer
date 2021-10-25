#!/bin/bash

############################################################################################################################################

# Fedora installer sysoply.pl Paweł Pietryszak 2021

############################################################################################################################################
# GTK theme
gsettings set org.gnome.desktop.interface gtk-theme "Adwaita-dark"

# DNF settings
sudo bash -c 'echo "fastestmirror=True
max_parallel_downloads=10
defaultyes=True">> /etc/dnf/dnf.conf'
sudo sed -i 's/installonly_limit=3/installonly_limit=2/g' /etc/dnf/dnf.conf

# Update system
sudo dnf -y update

# RPM Fusion - extra repo for apps not provided by Fedora or RH free and nonfree
sudo dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

# Add RPM Fusion to Gnome Software
sudo dnf groupupdate -y core

# Add multimedia codecs
sudo dnf groupupdate -y multimedia --setop="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin
sudo dnf groupupdate -y  sound-and-video

# Audio and Video plugins
sudo dnf install -y gstreamer1-plugins-{bad-\*,good-\*,base} gstreamer1-plugin-openh264 gstreamer1-libav --exclude=gstreamer1-plugins-bad-free-devel
sudo dnf install -y lame\* --exclude=lame-devel
sudo dnf group upgrade -y --with-optional Multimedia

# DVD codecs
sudo dnf install -y rpmfusion-free-release-tainted
sudo dnf install -y libdvdcss

# Nonfree firmawre 
sudo dnf install -y rpmfusion-nonfree-release-tainted
sudo dnf install -y \*-firmware

# Intel multimedia codecs
sudo dnf install -y intel-media-driver
sudo dnf install -y libva-intel-driver 

# Install codecs 
sudo dnf install -y ffmpeg

# Create folders
mkdir ~/.gc

# Gnome extensions
sudo dnf install -y gnome-extensions-app 
sudo dnf install -y gnome-tweaks

# Neovim
sudo dnf install -y neovim

# Neofetch
sudo dnf install -y neofetch

# Htop
sudo dnf install -y htop

# Thunderbird
sudo dnf install -y thunderbird

# Gimp
sudo dnf install -y gimp

# Spotify
flatpak install -y spotify
sudo ln -s /var/lib/flatpak/exports/bin/com.spotify.Client /usr/bin/spotify

# Sensors
sudo dnf install -y lm_sensors
echo " 
############################################################################################################################################

# FINDING SENSORS. IT'S TAKE A TIME. PLEASE WAIT !

############################################################################################################################################
"
yes | sudo sensors-detect

# Remove apps th
# Folder cleanup
rm ~/install.sh

# Restart
sudo dnf upgrade --refresh
sudo dnf check
sudo dnf -y autoremove
sudo dnf update
sudo reboot
