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

# Remove apps 
sudo dnf remove -y gnome-maps gnome-clocks rhythmbox gnome-weather gnome-contacts gnome-tour totem gnome-terminal

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

# Gnome extensions
sudo dnf install -y gnome-extensions-app 
sudo dnf install -y gnome-tweaks

# Wl-clipboard
sudo dnf install -y wl-clipboard

# Neovim
sudo dnf install -y neovim python3-neovim
sudo dnf install -y powerline-fonts

# Nodejs for neovim plugins
sudo dnf install -y nodejs

# Vim-plug
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# Bat - new cat ;)
sudo dnf install -y bat

# Perl for fzf
sudo dnf install -y perl

# Ripgrep
sudo dnf install -y ripgrep

# Most = man pager
sudo dnf install -y most

# Grimshot - sway screenshot tool
sudo dnf install -y grimshot
mkdir -p $HOME/Pictures/screenshots
echo 'XDG_SCREENSHOTS_DIR="$HOME/Pictures/screenshots"' | sudo tee -a ~/.config/user-dirs.dirs

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

# Sway
sudo dnf install -y sway 

# Remove apps 
sudo dnf remove -y alacritty

# Insall terminator
sudo dnf install -y terminator

# Install kernel headers
sudo dnf install -y kernel-devel kernel-headers    

# Virtualbox
echo " 
############################################################################################################################################

# INSTALLING KERNEL HEADERS. IT'S TAKE A TIME. PLEASE WAIT !

############################################################################################################################################
"
sudo dnf install -y VirtualBox kernel-devel-$(uname -r) akmod-VirtualBox
sudo akmods   
sudo systemctl restart vboxdrv  
lsmod  | grep -i vbox
sudo usermod -a -G vboxusers $USER   
sudo modprobe vboxdrv  

# Virtualbox extensions pack
cd ~/.gc
mkdir -p VirtualBox
cd virtualbox
LatestVirtualBoxVersion=$(wget -qO - https://download.virtualbox.org/virtualbox/LATEST-STABLE.TXT) && wget "https://download.virtualbox.org/virtualbox/${LatestVirtualBoxVersion}/Oracle_VM_VirtualBox_Extension_Pack-${LatestVirtualBoxVersion}.vbox-extpack"
yes | sudo VBoxManage extpack install --replace Oracle_VM_VirtualBox_Extension_Pack-${LatestVirtualBoxVersion}.vbox-extpack

# Virtualbox NAT Network
VBoxManage natnetwork add --netname NatNetwork --network "10.0.2.0/24" --enable

# Install caprine
sudo dnf copr enable -y  dusansimic/caprine 
sudo dnf update -y
sudo dnf install -y caprine

# Install VSCode
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
dnf check-update
sudo dnf install -y code

# Install VSCode plugins
code --install-extension esbenp.prettier-vscode
code --install-extension redhat.vscode-xml
code --install-extension visualstudioexptteam.vscodeintellicode
code --install-extension ms-azuretools.vscode-docker   
code --install-extension redhat.vscode-yaml 
code --install-extension xadillax.viml
code --install-extension jonathanharty.gruvbox-material-icon-theme
code --install-extension jdinhlife.gruvbox

# Rust 
sudo dnf install -y rust cargo

# Python pip
sudo dnf install -y python3-pip

# Sway info for windows classes
pip install --user swaytools  

# Spotify flatpak
sudo flatpak install -y spotify 
 
# Ncspot
sudo dnf install -y pulseaudio-libs-devel libxcb-devel openssl-devel ncurses-devel dbus-devel
cd ~/.gc
git clone https://github.com/hrkfdn/ncspot.git
cd ncspot
cargo install ncspot
 
# Spotifyd deamon for spotfitui
sudo dnf copr enable -y szpadel/spotifyd
sudo dnf install -y spotifyd
systemctl --user start spotifyd.service 
systemctl --user enable spotifyd.service  

# Spotify TUI
sudo dnf copr enable -y atim/spotify-tui
sudo dnf install -y spotify-tui

# Barshrc alias for user
echo  >> ~/.bashrc
echo alias vim='nvim' >> ~/.bashrc
echo alias vi='nvim' >> ~/.bashrc
source ~/.bashrc
sudo bash -c "sudo echo  >> /root/.bashrc"
sudo bash -c "sudo echo alias vim='nvim' >> /root/.bashrc"
sudo bash -c "sudo echo alias vi='nvim' >> /root/.bashrc"
sudo bash -c  "source ~/.bashrc"

# GTK Gruvbox theme
cd ~/.gc
git clone https://github.com/TheGreatMcPain/gruvbox-material-gtk.git
cd gruvbox-material-gtk
mkdir -p ~/.local/share/themes/
cp -r themes/* ~/.local/share/themes/
cd

# Papirus gtk icons for gruvbox 
sudo wget -qO- https://git.io/papirus-icon-theme-install | sh

# My FF profile
cd ~/.gc
wget https://sysoply.pl/download/.mozilla.zip
unzip .mozilla.zip
rm .mozilla.zip
cp -r .mozilla/ ~/

# ZSH 
sudo dnf install -y zsh
chsh -s $(which zsh)

# FZF
cd ~/.gc
git clone --depth 1 https://github.com/junegunn/fzf.git
cd fzf
yes | ./install

# Oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# Oh-my-zsh addons
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
cd ~/.gc
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# My dotfiles
cd ~/.gc/
git clone https://github.com/pietryszak/dotfiles.git

# Copy icons from dotfiles to proper folder
cd dotfiles/themes/
mkdir -p ~/.local/share/icons
tar -xf Gruvbox.tar.gz -C ~/.local/share/icons/

# Copy bat  config to proper folder
\cp -r ~/.gc/dotfiles/bat ~/.config

# Copy bpytop config to proper folder
\cp -r ~/.gc/dotfiles/bpytop ~/.config

# Copy Code config to proper folder
\cp -r ~/.gc/dotfiles/Code ~/.config

# Copy htop config to proper folder 
\cp -r ~/.gc/dotfiles/htop ~/.config

# Copy ncspot config to proper folder
\cp -r ~/.gc/dotfiles/ncspot ~/.config

# Copy neofetch config to proper folder
\cp -r ~/.gc/dotfiles/neofetch ~/.config

# Copy nvim config to proper folder
\cp -r ~/.gc/dotfiles/nvim ~/.config

# Copy shortcuts list to proper folder
\cp -r ~/.gc/dotfiles/shortcuts ~/.config

# Copy spotifyd list to proper folder
\cp -r ~/.gc/dotfiles/spotifyd ~/.config

# Copy spotify-tui list to proper folder
\cp -r ~/.gc/dotfiles/spotify-tui ~/.config

# Copy sway list to proper folder
\cp -r ~/.gc/dotfiles/sway ~/.config

# Copy virtualbox list to proper folder
\cp -r ~/.gc/dotfiles/virtualbox ~/.config

# Copy zsh list to proper folder
\cp -r ~/.gc/dotfiles/zsh ~/.config

# Copy zshrc list to proper folder
\cp -r ~/.config/zsh/.zshrc ~/

# Copy ublock list to proper folder
\cp -r ~/.gc/dotfiles/ublock/my-ublock-backup.txt ~/Downloads

# Sensors
sudo dnf install -y lm_sensors
echo " 
############################################################################################################################################

# FINDING SENSORS. IT'S TAKE A TIME. PLEASE WAIT !

############################################################################################################################################
"
yes | sudo sensors-detect

# Last update
sudo dnf upgrade --refresh
sudo dnf check
sudo dnf autoremove -y
sudo dnf update -y
sudo dnf upgrade -y

# Sudo timeout back to default
sudo sed -i 's/Defaults        env_reset,timestamp_timeout=60/#Defaults        env_reset,timestamp_timeout=60/g' /etc/default/grub

# Reboot
sudo reboot
