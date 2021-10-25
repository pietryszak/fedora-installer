#!/bin/bash

############################################################################################################################################

# Fedora installer sysoply.pl Paweł Pietryszak 2021

############################################################################################################################################

# DNF settings
sudo bash -c 'echo "fastestmirror=True
max_parallel_downloads=10
defaultyes=True">> /etc/dnf/dnf.conf'

# RPM Fusion - extra repo for apps not provided by Fedora or RH
sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
sudo dnf groupupdate core
sudo dnf groupupdate multimedia --setop="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin
sudo dnf groupupdate sound-and-video
sudo dnf install rpmfusion-free-release-tainted
sudo dnf install libdvdcss
sudo dnf install rpmfusion-nonfree-release-tainted
sudo dnf install \*-firmware

# Update system
sudo dnf -y update

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


