#!/bin/bash

############################################################################################################################################

# Fedora i3-gaps installer sysoply.pl Paweł Pietryszak 2021

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
sudo dnf remove -y gnome-maps gnome-clocks rhythmbox gnome-weather gnome-contacts gnome-tour totem

# Update system
sudo dnf -y upgrade

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
sudo bash -c 'echo "EDITOR=nvim" >> /etc/environment'
y
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

# Neofetch
sudo dnf install -y neofetch

# Htop
sudo dnf install -y htop

# btop
cd ~/.gc
git clone https://github.com/aristocratos/btop.git
cd btop
make
sudo make install

# nnn
sudo dnf install -y nnn 

# Thunderbird
sudo dnf install -y thunderbird

# Gimp
sudo dnf install -y gimp

# Ms fonts 
sudo dnf install -y cabextract xorg-x11-font-utils
sudo rpm -i https://downloads.sourceforge.net/project/mscorefonts2/rpms/msttcore-fonts-installer-2.6-1.noarch.rpm

# Flathub
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# Snap
sudo dnf install -y snapd
sudo ln -s /var/lib/snapd/snap /snap

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

# Install terminator - terminal for vm
sudo dnf install -y terminator

# Install kitty - terminal for pc
sudo dnf install -y kitty

# Install transsmision
sudo dnf install -y transmission

# Install redshift
sudo dnf install -y redshift-gtk

# Install kernel headers
red=`tput setaf 1`
bold=`tput bold`
reset=`tput sgr0`
echo "${red}${bold}INSTALLING KERNEL HEADERS. IT'S TAKE A TIME. PLEASE WAIT.${reset}"
sudo dnf install -y kernel-devel kernel-headers    

# Virtualbox
sudo dnf install -y VirtualBox kernel-devel-$(uname -r) akmod-VirtualBox
sudo akmods   
sudo systemctl restart vboxdrv  
lsmod  | grep -i vbox
sudo usermod -a -G vboxusers $USER   
sudo modprobe vboxdrv  

# Virtualbox extensions pack
cd ~/.gc
mkdir -p VirtualBox
cd VirtualBox
LatestVirtualBoxVersion=$(wget -qO - https://download.virtualbox.org/virtualbox/LATEST-STABLE.TXT) && wget "https://download.virtualbox.org/virtualbox/${LatestVirtualBoxVersion}/Oracle_VM_VirtualBox_Extension_Pack-${LatestVirtualBoxVersion}.vbox-extpack"
yes | sudo VBoxManage extpack install --replace Oracle_VM_VirtualBox_Extension_Pack-${LatestVirtualBoxVersion}.vbox-extpack

# Virtualbox NAT Network
VBoxManage natnetwork add --netname NatNetwork --network "10.0.2.0/24" --enable

# Vmware Workstation
cd ~/.gc
wget --user-agent="Mozilla/5.0 (X11; Fedora; Linux x86_64; rv:94.0) Gecko/20100101 Firefox/94.0" https://www.vmware.com/go/getworkstation-linux
chmod a+x getworkstation-linux
sudo ./getworkstation-linux  --console --required --eulas-agreed    
sudo bash -c 'echo "mks.gl.allowBlacklistedDrivers = "TRUE"" >> ~/.vmware/preferences'

# Install Virt-manager for KVM
sudo dnf group install -y --with-optional virtualization
sudo systemctl start libvirtd
sudo systemctl enable libvirtd
sudo usermod -a -G libvirt $USER 

# TeamViewer
cd ~/.gc
wget https://download.teamviewer.com/download/linux/teamviewer.x86_64.rpm
sudo dnf -y install ./teamviewer.x86_64.rpm
cd

# Install caprine
sudo dnf copr enable -y  dusansimic/caprine 
sudo dnf upgrade -y
sudo dnf install -y caprine

# Install VSCode
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
dnf check-upgrade
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
code --install-extension naumovs.color-highlight

# Rust 
sudo dnf install -y rust cargo

# Python pip
sudo dnf install -y python3-pip

# 7zip
sudo dnf install -y p7zip p7zip-plugins

# Spotify snap
sudo snap install snap-store
sudo snap install spotify 

# Ymuse - classic music player for mp3 etc.
cd ~/.gc
URL=$(curl -L -s https://api.github.com/repos/yktoo/ymuse/releases/latest | grep -o -E "https://(.*)ymuse_(.*)_linux_amd64.rpm") | wget $URL && mv ymuse*.rpm ymuse.rpm && sudo rpm -i --nodeps ymuse.rpm && rm ymuse.rpm
cd

# Meson
sudo dnf install -y meson

# Cmake
sudo dnf install -y cmake

# Zenkit
cd ~/.gc
wget https://static.zenkit.com/downloads/desktop-apps/base/zenkit-base-linux.rpm
sudo rpm -i zenkit-base-linux.rpm 

# Notorious dependiences
sudo dnf install -y gtk3-devel
sudo dnf install -y gobject-introspection-devel 
 
# Notorious
cd ~/.gc 
git clone https://gitlab.gnome.org/GabMus/notorious
cd notorious
mkdir build
cd build
meson ..
meson configure -Dprefix=$PWD/testdir
ninja
ninja install
sudo cp ~/.gc/notorious/build/testdir/bin/notorious /usr/bin
cd

# Mega.nz for notorious sync
sudo dnf install -y megasync

# Bluez for bluetooth 
sudo dnf -y install bluez bluez-tools
bluetoothctl discoverable on

# Blueman for bluetooth applet
sudo dnf install -y blueman 

# Spotifyd deamon for spotfitui
sudo dnf copr enable -y szpadel/spotifyd
sudo dnf install -y spotifyd
systemctl --user start spotifyd.service 
systemctl --user enable spotifyd.service  

# Spotify TUI
sudo dnf copr enable -y atim/spotify-tui
sudo dnf install -y spotify-tui

# Bash aliases for user
bash -c 'echo "
if [ -f ~/.bash_aliases ]; then
. ~/.bash_aliases
fi">> ~/.bashrc'

# Bash aliases for sudo/root
sudo bash -c 'echo "
if [ -f ~/.bash_aliases ]; then
. ~/.bash_aliases
fi">> ~/.bashrc'

# GTK Gruvbox theme
cd ~/.gc
git clone https://github.com/TheGreatMcPain/gruvbox-material-gtk.git
cd gruvbox-material-gtk
mkdir -p ~/.local/share/themes/
cp -r themes/* ~/.local/share/themes/
cd

# QT5 apps theme
sudo dnf install -y qt5ct
sudo bash -c 'echo "QT_QPA_PLATFORMTHEME=qt5ct" >> /etc/environment'

# Papirus gtk icons for gruvbox 
cd ~/.gc
sudo wget -qO- https://git.io/papirus-icon-theme-install | sh

# Papirus folders
wget -qO- https://git.io/papirus-folders-install | sh
papirus-folders -C brown --theme Papirus-Dark
cd

# ZSH 
sudo dnf install -y util-linux-user
sudo dnf install -y zsh
sudo chsh -s $(which zsh) $USER

# FZF
cd ~/.gc
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
yes | ~/.fzf/install
cd

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

# i3-gaps
# sudo dnf install i3-gaps
sudo dnf install -y libxcb-devel xcb-util-keysyms-devel xcb-util-devel xcb-util-wm-devel xcb-util-xrm-devel yajl-devel libXrandr-devel startup-notification-devel libev-devel xcb-util-cursor-devel libXinerama-devel libxkbcommon-devel libxkbcommon-x11-devel pcre-devel pango-devel git gcc automake asciidoc xmlto
sudo dnf install -y i3status-config libconfuse perl-AnyEvent perl-AnyEvent-I3 perl-JSON-XS perl-Types-Serialiser perl-common-sense xorg-x11-fonts-misc dmenu i3lock i3status perl-Guard perl-Task-Weaken pulseaudio-utils
cd ~/.gc
git clone https://www.github.com/Airblader/i3 i3-gaps
cd i3-gaps
mkdir -p build && cd build
meson -Ddocs=true -Dmans=true
meson compile
sudo meson install 

# i3-wifi applet
sudo dnf install -y network-manager-applet

# i3 screen saver extension for X 
sudo dnf install -y xss-lock

# Arandr -screen layout
sudo dnf install -y arandr

# Polybar - i3 statusbar
sudo dnf install -y polybar

# Feh for i3 wallpapers
sudo dnf install -y feh

# Rofi menu for i3
sudo dnf install -y rofi

# Picom for 13  compositor for X
sudo dnf install -y picom

# Dusnt i3 notifications
sudo dnf install -y dunst 

# Numlockx for i3 - numlock on at startup
sudo dnf install -y numlockx

# Pywal - Generate and change color-schemes on the fly. For polybar
pip3 install pywal

# Polybar themes
cd ~/.gc
git clone --depth=1 https://github.com/adi1090x/polybar-themes.git
cd polybar-themes
cp -rf fonts/* ~/.local/share/fonts
fc-cache -fv

# Polybar weather module fonts
cd ~/.gc
https://github.com/erikflowers/weather-icons.git
cp ~/.gc/weather-icons/font/weathericons-regular-webfont.ttf ~/.local/share/fonts
fc-cache -fv

# Polybar Spotify 
cd ~/.gc
git clone https://github.com/Jvanrhijn/polybar-spotify.git
cd

/# Gnome-polkit - dispaly popup fot password for sudo 
sudo dnf install -y gnome-polkit

# Sensors
sudo dnf install -y lm_sensors
red=`tput setaf 1`
bold=`tput bold`
reset=`tput sgr0`
echo "${red}${bold}FINDING SENSORS. IT'S TAKE A TIME. PLEASE WAIT.${reset}"
yes | sudo sensors-detect

# My dotfiles
cd ~/.gc
git clone https://github.com/pietryszak/dotfiles.git

# Copy bat  config to proper folder
\cp -r ~/.gc/dotfiles/bat ~/.config

# Copy Code config to proper folder
\cp -r ~/.gc/dotfiles/Code/settings.json ~/.config/Code/User/

# Copy htop config to proper folder 
\cp -r ~/.gc/dotfiles/htop ~/.config

# Copy neofetch config to proper folder
\cp -r ~/.gc/dotfiles/neofetch ~/.config

# Copy nvim config to proper folder
\cp -r ~/.gc/dotfiles/nvim ~/.config

# Copy shortcuts list to proper folder
\cp -r ~/.gc/dotfiles/shortcuts ~/.config

# Copy spotifyd config to proper folder
\cp -r ~/.gc/dotfiles/spotifyd ~/.config

# Copy spotify-tui config to proper folder
\cp -r ~/.gc/dotfiles/spotify-tui ~/.config

# Copy VirtualBox config to proper folder 
\cp -r ~/.gc/dotfiles/VirtualBox ~/.config
chmod +x ~/.config/VirtualBox/update.sh

# Copy Caprine config to proper folder
\cp -r ~/.gc/dotfiles/Caprine ~/.config

# Copy zsh sripts to proper folder
\cp -r ~/.gc/dotfiles/zsh/scripts/* ~/.oh-my-zsh/custom

# Copy zshrc config to proper folder
\cp -r ~/.gc/dotfiles/zsh/.zshrc ~/

# Copy zshrc config to proper folder
\cp -r ~/.gc/dotfiles/zsh/.p10k.zsh ~/

# Copy terminator config to proper folder
\cp -r ~/.gc/dotfiles/terminator/ ~/.config

# Copy TeamViewer config to proper folder
\cp -r ~/.gc/dotfiles/teamviewer/ ~/.config

# Copy Redshitf config to proper folder
\cp -r ~/.gc/dotfiles/redshift/ ~/.config

# Copy Notorious desktop file to proper folder
sudo \cp -r ~/.gc/dotfiles/notorious/* /usr/share/applications/

# Copy bash_aliases to user folder
\cp -r ~/.gc/dotfiles/bashrc/.bash_aliases ~/ 

# Copy bash_aliases to sudo/root folder
sudo \cp -r ~/.gc/dotfiles/bashrc/.bash_aliases /root  

# Copy qt5ct config to to proper folder
\cp -r ~/.gc/dotfiles/qt5ct ~/.config

# Copy gtk config to to proper folder
cp ~/.gc/dotfiles/gtk/.gtkrc-2.0 ~
cp ~/.gc/dotfiles/gtk/settings.ini ~/.config/gtk-3.0/

# Copy gedit config to to proper folder
sudo \cp -r ~/.gc/dotfiles/gedit/* /usr/share/gtksourceview-4/styles
gsettings set org.gnome.gedit.preferences.editor scheme 'gruvbox-dark' 

sudo dnf -y install ./teamviewer.x86_64.rpm

# Copy arandr config to to proper folder
\cp -r ~/.gc/dotfiles/screenlayout/* ~/.screenlayout
chmod +x ~/.screenlayout horizontal.sh
chmod +x ~/.screenlayout vertical.sh

# Copy shortcuts list to proper folder
\cp -r ~/.gc/dotfiles/shortcuts ~/.config

# Copy i3 config to to proper folder
\cp -r ~/.gc/dotfiles/i3 ~/.config
rm ~/.config/i3/scripts/vm-workspaces

# Copy polybar config to to proper folder
\cp -r ~/.gc/dotfiles/polybar ~/.config
cp ~/.gc/polybar-spotify/spotify_status.py ~/.config/polybar/scripts/
chmod +x ~/.config/polybar/cuts/launch.sh
chmod +x ~/.config/polybar/cuts/preview.sh
chmod +x ~/.config/polybar/cuts/scripts/*
chmod +x ~/.config/polybar/scripts/*
sed -i -e '/play_pause/s/25B6/F909/' ~/.config/polybar/scripts/spotify_status.py 
sed -i -e '/play_pause/s/23F8/F8E3/' ~/.config/polybar/scripts/spotify_status.py 

# My FF profile public
cd ~/.gc/dotfiles
wget https://sysoply.pl/download/public/mozilla-profile-public.7z
7z x mozilla-profile-public.7z
\cp -r .mozilla ~/

# My FF cache profile
cd ~/.gc/dotfiles
wget https://sysoply.pl/download/public/mozilla-cache-public.7z
7z x mozilla-cache-public.7z
\cp -r mozilla ~/.cache

# My Thunderbird profile public
cd ~/.gc/dotfiles
wget https://sysoply.pl/download/public/thunderbird-profile-public.7z
7z x thunderbird-profile-public.7z
\cp -r .thunderbird ~/

# My Thunderbird cache public
cd ~/.gc/dotfiles
wget https://sysoply.pl/download/public/thunderbird-cache-public.7z
7z x thunderbird-cache-public.7z
\cp -r thunderbird ~/.cache

# Remove apps 
sudo dnf remove -y gnome-terminal

# Last update
sudo dnf upgrade --refresh
sudo dnf upgrade -y
sudo dnf autoremove -y

# Sudo timeout back to default
sudo sed -i 's/Defaults        env_reset,timestamp_timeout=60/#Defaults        env_reset,timestamp_timeout=60/g' /etc/sudoers

# Reboot
sudo reboot
