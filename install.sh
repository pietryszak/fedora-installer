#!/bin/bash

############################################################################################################################################

# Fedora installer sysoply.pl Paweł Pietryszak 2021

############################################################################################################################################
# GTK theme
gsettings set org.gnome.desktop.interface gtk-theme "Adwaita-dark"

# Sudo timeout
sudo bash -c 'echo "
Defaults        env_reset,timestamp_timeout=60" >>  /etc/sudoers'

# DNF settings
sudo bash -c 'echo "fastestmirror=True
max_parallel_downloads=10
defaultyes=True" >> /etc/dnf/dnf.conf'
sudo sed -i 's/installonly_limit=3/installonly_limit=2/g' /etc/dnf/dnf.conf

# Update system
sudo dnf -y update

# Remove apps 
sudo dnf remove -y gnome-maps gnome-clocks rhythmbox gnome-weather gnome-contacts gnome-tour totem gnome-terminal

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

# Gnome extensions
sudo dnf install -y gnome-extensions-app 
sudo dnf install -y gnome-tweaks

# Neovim
sudo dnf install -y neovim python3-neovim
sudo dnf install -y powerline-fonts

# Nodejs for neovim plugins
sudo dnf install -y nodejs

# Vim-plug
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# FZF for neovim
sudo dnf install -y  fzf

# Bat - new cat ;)
sudo dnf install -y bat

# Perl for fzf
sudo dnf install -y perl

#
sudo dnf install -y ripgrep

# Neofetch
sudo dnf install -y neofetch

# Htop
sudo dnf install -y htop

# bpytop
sudo dnf install -y bpytop

# Thunderbird
sudo dnf install -y thunderbird

# Gimp
sudo dnf install -y gimp

# Ms fonts 
sudo dnf install -y cabextract xorg-x11-font-utils
sudo rpm -i https://downloads.sourceforge.net/project/mscorefonts2/rpms/msttcore-fonts-installer-2.6-1.noarch.rpm

# Flathub
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# Libreoffice draw
sudo dnf install -y libreoffice-draw

# ClamAV
sudo dnf install -y clamav clamd clamav-update clamtk
sudo setsebool -P antivirus_can_scan_system 1
sudo systemctl stop clamav-freshclam
sudo freshclam
sudo freshclam
sudo systemctl start clamav-freshclam
sudo systemctl enable clamav-freshclam

# Firewalld GUI
sudo dnf install -y firewall-config

# Zsh
sudo dnf install -y zsh

# Oh-my-zsh
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
mkdir /.config/oh-my-zsh/custom/scripts

# Oh-my-zsh addons
cd ~/.config/oh-my-zsh/custom/plugins
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# Powerlevel10k zsh
cd ~/.gc
mkdir fonts
cd fonts
wget https://raw.githubusercontent.com/romkatv/powerlevel10k-media/master/MesloLGS%20NF%20Regular.ttf
wget https://raw.githubusercontent.com/romkatv/powerlevel10k-media/master/MesloLGS%20NF%20Bold.ttf
wget https://raw.githubusercontent.com/romkatv/powerlevel10k-media/master/MesloLGS%20NF%20Italic.ttf
wget https://raw.githubusercontent.com/romkatv/powerlevel10k-media/master/MesloLGS%20NF%20Bold%20Italic.ttf
mkdir -p ~/.local/share/fonts/nerd
cp MesloLGS* ~/.local/share/fonts/nerd
fc-cache -fv

# Bat
sudo dnf install -y bat

# Sway
sudo dnf install -y sway 

# Remove apps 
sudo dnf remove -y alacritty

# Insall kitty
sudo dnf install -y kitty

# Install caprine
sudo dnf copr enable -y  dusansimic/caprine 
sudo dnf update -y
sudo dnf install -y caprine

# Install VSCode
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
dnf check-update
sudo dnf install -y code

# Install VSCodium plugins
code --install-extension esbenp.prettier-vscode
code --install-extension redhat.vscode-xml
code --install-extension visualstudioexptteam.vscodeintellicode
code --install-extension ms-azuretools.vscode-docker   
code --install-extension redhat.vscode-yaml 
code --install-extension xadillax.viml
code --install-extension jonathanharty.gruvbox-material-icon-theme
code --install-extension jdinhlife.gruvbox
           
# Barshrc alias
echo  >> ~/.bashrc
echo alias vim='nvim' >> ~/.bashrc
echo alias vi='nvim' >> ~/.bashrc
source ~/.bashrc
sudo echo  >> /root/.bashrc
sudo echo alias vim='nvim' >> /root/.bashrc
sudo echo alias vi='nvim' >> /root/.bashrc

# My FF profile
cd ~/.gc
wget https://sysoply.pl/download/.mozilla.zip
unzip .mozilla.zip
rm .mozilla.zip
cp -r .mozilla/ ~/
cd ~/Downloads
wget https://sysoply.pl/download/ublock-kopia-zapasowa_2021-10-06_14.09.44.txt
cd

# Sudo timeout back to default
sudo sed -i 's/Defaults        env_reset,timestamp_timeout=60/#Defaults        env_reset,timestamp_timeout=60/g' /etc/default/grub

# Last update
sudo dnf upgrade --refresh
sudo dnf check
sudo dnf autoremove -y
sudo dnf update -y

#Spotify
sudo dnf install -y lpf-spotify-client
sudo usermod -a -G pkg-build $USER
echo " 
############################################################################################################################################
# PLEASE PROVIDE YOUR PASSWORD !
############################################################################################################################################
"
su - $USER
