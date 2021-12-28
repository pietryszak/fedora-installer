#!/bin/bash

############################################################################################################################################

# Fedora i3-gaps installer sysoply.pl Paweł Pietryszak 2021

############################################################################################################################################

# Echo colors
magenta=`tput setaf 5`
green=`tput setaf 2`
bold=`tput bold`
reset=`tput sgr0`

# GTK theme
echo "${green}${bold}SETTING DARK GTK THEME${reset}"
gsettings set org.gnome.desktop.interface gtk-theme "Adwaita-dark"

# Sudo timeoutpolybar-scripts
echo "${green}${bold}SETTING SUDO TIMEOUT FOR 60 MINUTES FOR THE INSTALLATION PURPOSES${reset}"
sudo bash -c 'echo "
Defaults        env_reset,timestamp_timeout=60" >>  /etc/sudoers'

# Polish time locale
echo "${green}${bold}SETTING POLISH TIME AND DATE FORMAT${reset}"
sudo bash -c 'echo "
LC_NUMERIC=pl_PL.UTF-8
LC_TIME=pl_PL.UTF-8
LC_MONETARY=pl_PL.UTF-8
LC_PAPER=pl_PL.UTF-8
LC_MEASUREMENT=pl_PL.UTF-8" >> /etc/locale.conf'

# DNF settings
echo "${green}${bold}SETTING DNF BEST SETTINGS${reset}"
sudo bash -c 'echo "fastestmirror=True
max_parallel_downloads=10
defaultyes=True" >> /etc/dnf/dnf.conf'
sudo sed -i 's/installonly_limit=3/installonly_limit=2/g' /etc/dnf/dnf.conf

# Remove apps 
echo "${green}${bold}REMOVE UNNECESSARY GNOME APPS${reset}"
sudo dnf remove -y gnome-maps gnome-clocks gnome-weather gnome-contacts gnome-tour totem gnome-screenshot 

# Update system
echo "${green}${bold}UPDATE SYSTEM. IT'S TAKE TIME. PLEASE WAIT!${reset}"
sudo dnf -y upgrade

# RPM Fusion - extra repo for apps not provided by Fedora or RH free and nonfree
echo "${green}${bold}ADDING RPM FUSION REPOSITORIUM FOR APPS NOT PROVIDED BY FEDORA${reset}"
sudo dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

# Add RPM Fusion to Gnome Software
echo "${green}${bold}ADDING RPM FUSION REPOSITORIUM TO SOFTWARE SHOP${reset}"
sudo dnf groupupdate -y core

# Add multimedia codecs
echo "${green}${bold}ADDING MULTIMEDIA CODECS${reset}"
sudo dnf groupupdate -y multimedia --setop="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin
sudo dnf groupupdate -y  sound-and-video

# Audio and Video plugins
echo "${green}${bold}ADDING AUDIO AND VIDEO PLUGINS${reset}"
sudo dnf install -y gstreamer1-plugins-{bad-\*,good-\*,base} gstreamer1-plugin-openh264 gstreamer1-libav --exclude=gstreamer1-plugins-bad-free-devel
sudo dnf install -y lame\* --exclude=lame-devel
sudo dnf group upgrade -y --with-optional Multimedia

# DVD codecs
echo "${green}${bold}ADDING DVD CODECS${reset}"
sudo dnf install -y rpmfusion-free-release-tainted
sudo dnf install -y libdvdcss

# Nonfree firmawre 
echo "${green}${bold}ADDING NONFREE FIRMWARE${reset}"
sudo dnf install -y rpmfusion-nonfree-release-tainted
sudo dnf install -y \*-firmware

# Intel multimedia codecs
echo "${green}${bold}ADDING INTEL VIDEO ACCELERATION API${reset}"
sudo dnf install -y intel-media-driver
sudo dnf install -y libva-intel-driver 

# Codecs 
echo "${green}${bold}ADDING FFMPEG CODECS${reset}"
sudo dnf install -y ffmpeg

# Mpv
# Codecs 
echo "${green}${bold}INSTALLING MPV. VIDEO APP${reset}"
sudo dnf install -y mpv

# Gnome extensions
echo "${green}${bold}INSTALLING GNOME TWEAKS${reset}"
sudo dnf install -y gnome-extensions-app 
sudo dnf install -y gnome-tweaks

# Neovim
echo "${green}${bold}INSTALLING NEOVIM${reset}"
sudo dnf install -y neovim python3-neovim
sudo bash -c 'echo "EDITOR=nvim" >> /etc/environment'

# Nodejs for neovim plugins
echo "${green}${bold}INSTALLING NODEJS FOR VIM PLUGINS${reset}"
sudo dnf install -y nodejs

# Vim-plug
echo "${green}${bold}INSTALLING VIM-PLUG. VIM PLUGINS INSTALLER${reset}"
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# Bat - new cat ;)
echo "${green}${bold}INSTALLING BAT. BETTER CAT COMMAND${reset}"
sudo dnf install -y bat

# Ripgrep
echo "${green}${bold}INSTALLING RIPGREP. NEW REPLECMENT FOR GREP${reset}"
sudo dnf install -y ripgrep

# Most = man pager
echo "${green}${bold}INSTALLING MOST. BETTER MAN HIGHLIGHTING${reset}"
sudo dnf install -y most

# Neofetch
echo "${green}${bold}INSTALLING NEOFETCH. SYSTEM INFO IN TERMINAL ${reset}"
sudo dnf install -y neofetch

# Htop
echo "${green}${bold}INSTALLING HTOP. BETTER TOP COMMAND${reset}"
sudo dnf install -y htop

# Bpytop
echo "${green}${bold}INSTALLING BTOP. TOP WITH MOUSE SUPPORT${reset}"
sudo dnf install -y bpytop

# Nnn
echo "${green}${bold}INSTALLING NNN. FILE MANAGER IN TERMINAL${reset}"
sudo dnf install -y nnn

# Thunderbird
echo "${green}${bold}INSTALLING THUNDERBIRD. MAIL CLIENT${reset}"
sudo dnf install -y thunderbird

# Gimp
echo "${green}${bold}INSTALLING GIMP. GRAPHICS APP${reset}"
sudo dnf install -y gimp

# Flameshot
echo "${green}${bold}INSTALLING FLAMESHOT. SCREENSHOTS APP${reset}"
sudo dnf install -y flameshot

# Libreoffice draw
echo "${green}${bold}INSTALLING LIBREOFFICE DRAW FOR PDF EDITING${reset}"
sudo dnf install -y libreoffice-draw

# ClamAV
echo "${green}${bold}INSTALLING CLAMAV. BEST LINUX ANTIVIRUS${reset}"
sudo dnf install -y clamav clamd clamav-update clamtk
sudo setsebool -P antivirus_can_scan_system 1
sudo systemctl stop clamav-freshclam
sudo freshclam
sudo freshclam
sudo systemctl start clamav-freshclam
sudo systemctl enable clamav-freshclam

# Firewalld GUI
echo "${green}${bold}INSTALLING FIREWALL GUI${reset}"
sudo dnf install -y firewall-config

# Timeshift
echo "${green}${bold}INSTALLING TIMESHIFT. BACKUP TOOL${reset}"
sudo dnf install -y timeshift

# Terminator - terminal for vm
echo "${green}${bold}INSTALLING TERMINATOR. TERMINAL FOR VIRTUALMASHINE${reset}"
sudo dnf install -y terminator

# Kitty - terminal for pc
echo "${green}${bold}INSTALLING KITTY. TERMINAL FOR PC${reset}"
sudo dnf install -y kitty

# Transsmision
echo "${green}${bold}INSTALLING TRANSMISSION. TORRENT APP${reset}"
sudo dnf install -y transmission

# Redshift
echo "${green}${bold}INSTALLING REDSHIFT. ADJUST THE COLOR TEMPERATURE OF SCREEN${reset}"
sudo dnf install -y redshift-gtk

# Kernel headers
echo "${green}${bold}INSTALLING KERNEL HEADERS. IT'S TAKE A TIME. PLEASE WAIT!${reset}"
sudo dnf install -y kernel-devel kernel-headers    

# Virtualbox
echo "${green}${bold}INSTALLING VIRTUALBOX${reset}"
sudo dnf install -y VirtualBox akmod-VirtualBox
sudo akmods   
sudo systemctl restart vboxdrv  
lsmod  | grep -i vbox
sudo usermod -a -G vboxusers $USER   
sudo modprobe vboxdrv  

# Virtualbox extensions pack
echo "${green}${bold}INSTALLING VIRTUALBOX EXTENSION PACK${reset}"
cd ~/.gc
mkdir -p VirtualBox
cd VirtualBox
LatestVirtualBoxVersion=$(wget -qO - https://download.virtualbox.org/virtualbox/LATEST-STABLE.TXT) && wget "https://download.virtualbox.org/virtualbox/${LatestVirtualBoxVersion}/Oracle_VM_VirtualBox_Extension_Pack-${LatestVirtualBoxVersion}.vbox-extpack"
yes | sudo VBoxManage extpack install --replace Oracle_VM_VirtualBox_Extension_Pack-${LatestVirtualBoxVersion}.vbox-extpack

# Virtualbox NAT Network
echo "${green}${bold}ADDING VIRTUALBOX NAT NETWORK${reset}"
VBoxManage natnetwork add --netname NatNetwork --network "10.0.2.0/24" --enable

# Vmware Workstation
echo "${green}${bold}INSTALLING VMWARE WORKSTATION. IT'S TAKE A TIME. PLEASE WAIT!${reset}"
cd ~/.gc
wget --user-agent="Mozilla/5.0 (X11; Fedora; Linux x86_64; rv:94.0) Gecko/20100101 Firefox/94.0" https://www.vmware.com/go/getworkstation-linux
chmod a+x getworkstation-linux
sudo ./getworkstation-linux  --console --required --eulas-agreed    
rm getworkstation-linux

# Virt-manager for KVM
echo "${green}${bold}INSTALLING VIRT MANAGER FOR KVM${reset}"
sudo dnf group install -y --with-optional virtualization
sudo systemctl start libvirtd
sudo systemctl enable libvirtd
sudo usermod -a -G libvirt $USER 

# TeamViewer
echo "${green}${bold}INSTALLING TEAMVIEWER${reset}"
cd ~/.gc
wget https://download.teamviewer.com/download/linux/teamviewer.x86_64.rpm
sudo dnf -y install ./teamviewer.x86_64.rpm
rm teamviewer.x86_64.rpm
cd

# Caprine - FB messenger
echo "${green}${bold}INSTALLING CAPRINE. FACEBOOK MESSENGER APP${reset}"
sudo dnf copr enable -y dusansimic/caprine 
sudo dnf upgrade -y
sudo dnf install -y caprine

# VSCode
echo "${green}${bold}INSTALLING VSCODE. CODING APP FROM MICROSOFT${reset}"
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
sudo dnf -y check-upgrade
sudo dnf install -y code

# VSCode plugins
echo "${green}${bold}INSTALLING VSCODE PLUGINS${reset}"
code --install-extension visualstudioexptteam.vscodeintellicode
code --install-extension ms-python.python
code --install-extension esbenp.prettier-vscode
code --install-extension redhat.vscode-xml
code --install-extension redhat.vscode-yaml 
code --install-extension ms-azuretools.vscode-docker   
code --install-extension xadillax.viml
code --install-extension jonathanharty.gruvbox-material-icon-theme
code --install-extension jdinhlife.gruvbox
code --install-extension naumovs.color-highlight
code --install-extension nico-castell.linux-desktop-file
code --install-extension xadillax.viml
code --install-extension dlasagno.rasi
code --install-extension dcasella.i3

# Perl for fzf, Rust, Python pip
echo "${green}${bold}INSTALLING PERL, RUST. POPULAR PROGRAMMING LANGUAGES IN LINUX. FOR APPS USED IN SYSTEM${reset}"
sudo dnf install -y perl
sudo dnf install -y rust cargo

# Python pip, meson
echo "${green}${bold}INSTALLING PHP PIP, MESON, CMAKE, JQ. BUILD SYSTEM FOR APPS${reset}"
sudo dnf install -y python3-pip
sudo dnf install -y meson
sudo dnf install -y cmake
sudo dnf install -y jq

# 7zip
echo "${green}${bold}INSTALLING 7ZIP. ARCHIVE APP${reset}"
sudo dnf install -y p7zip p7zip-plugins

# Bluez for bluetooth 
echo "${green}${bold}INSTALLING BLUEZ. BLUETOOTH PROTOCOL STACK FOR LINUX${reset}"
sudo dnf -y install bluez bluez-tools
bluetoothctl discoverable on

# Blueman for bluetooth applet
echo "${green}${bold}INSTALLING BLUEMAN. BLUETOOTH APPLET${reset}"
sudo dnf install -y blueman 

# Spotifyd deamon for spotfitui
echo "${green}${bold}INSTALLING SPOTIFYD. SPOTIFY DAEMON FOR SPOTIFY TUI${reset}"
sudo dnf copr enable -y szpadel/spotifyd
sudo dnf install -y spotifyd
systemctl --user start spotifyd.service 
systemctl --user enable spotifyd.service  

# Spotify TUI
echo "${green}${bold}INSTALLING SPOTIFY TUI. SPOTIFY IN TERMINAL${reset}"
sudo dnf copr enable -y atim/spotify-tui
sudo dnf install -y spotify-tui

# Bash aliases for user
echo "${green}${bold}ADING BASH ALIASES FOR USER${reset}"
bash -c 'echo "
if [ -f ~/.bash_aliases ]; then
. ~/.bash_aliases
fi">> ~/.bashrc'

# Bash aliases for sudo/root
echo "${green}${bold}ADDING BASH ALIASES TO ROOT USER${reset}"
sudo bash -c 'echo "
if [ -f ~/.bash_aliases ]; then
. ~/.bash_aliases
fi">> ~/.bashrc'

# QT5 apps theme
echo "${green}${bold}SET QT5 APPS THEME${reset}"
sudo dnf install -y qt5ct
sudo bash -c 'echo "QT_QPA_PLATFORMTHEME=qt5ct" >> /etc/environment'

# Papirus gtk icons for gruvbox 
echo "${green}${bold}SET GTK ICONS${reset}"
cd ~/.gc
sudo wget -qO- https://git.io/papirus-icon-theme-install | sh

# Papirus folders
echo "${green}${bold}SET FOLDERS COLORS${reset}"
wget -qO- https://git.io/papirus-folders-install | sh
papirus-folders -C brown --theme Papirus-Dark
cd

# ZSH 
echo "${green}${bold}INSTALLING ZSH. UNIX SHELL WITH NEW FUTURES${reset}"
sudo dnf install -y util-linux-user
sudo dnf install -y zsh
sudo chsh -s $(which zsh) $USER

# FZF
echo "${green}${bold}INSTALLING FZF. COMMAND LINE FUZY FINDER ${reset}"
cd .gc
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
yes | ~/.fzf/install
cd

# Oh-my-zsh
echo "${green}${bold}INSTALLING OH MY ZSH. FRAMEWORK FOR ZSH${reset}"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# Oh-my-zsh plugins
echo "${green}${bold}ADDING ZSH PLUGINS${reset}"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# Fonts 
echo "${green}${bold}ADDING FONTS TO SYSTEM ${reset}"
sudo dnf install -y powerline-fonts
sudo dnf install -y cabextract xorg-x11-font-utils
cd ~/.gc
git clone https://github.com/pietryszak/fonts.git
cd fonts
sudo dnf install -y msttcore-fonts-installer-2.6-1.noarch.rpm
mkdir -p ~/.local/share/fonts
cp feather.ttf ~/.local/share/fonts
cp iosevka_nerd_font.ttf ~/.local/share/fonts
cp MesloLGS* ~/.local/share/fonts/
cp weathericons-regular-webfont.ttf ~/.local/share/fonts
fc-cache -fv
cd

# Powerlevel10k zsh
echo "${green}${bold}INSTALLING POWERLEVEL10K. ZSH THEME${reset}"
cd ~/.gc
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# i3-gaps
echo "${green}${bold}INSTALLING I3-GAPS${reset}"
sudo dnf install -y libxcb-devel xcb-util-keysyms-devel xcb-util-devel xcb-util-wm-devel xcb-util-xrm-devel yajl-devel libXrandr-devel startup-notification-devel libev-devel xcb-util-cursor-devel libXinerama-devel libxkbcommon-devel libxkbcommon-x11-devel pcre-devel pango-devel git gcc automake asciidoc xmlto
sudo dnf install -y i3status-config libconfuse perl-AnyEvent perl-AnyEvent-I3 perl-JSON-XS perl-Types-Serialiser perl-common-sense xorg-x11-fonts-misc dmenu i3lock i3status perl-Guard perl-Task-Weaken pulseaudio-utils
sudo dnf copr enable -y fuhrmann/i3-gaps
sudo dnf install -y i3-gaps

# i3-wifi applet
echo "${green}${bold}INSTALLING I3 WIFI APPLET${reset}"
sudo dnf install -y network-manager-applet

# i3-volume applet
echo "${green}${bold}INSTALLING I3 VOLUME APPLET${reset}"
sudo dnf install -y volumeicon

# i3 screen saver extension for X 
echo "${green}${bold}INSTALLING I3 SCREEN SAVER${reset}"
sudo dnf install -y xss-lock

# Arandr -screen layout
echo "${green}${bold}INSTALLING ARANDR. XRANDR GUI${reset}"
sudo dnf install -y arandr

# Polybar - i3 statusbar
echo "${green}${bold}INSTALLING POLYBAR. I3 BAR${reset}"
sudo dnf install -y polybar

# Yad for polybar calendar
echo "${green}${bold}INSTALLING I3 CALENDAR APPLET${reset}"
sudo dnf install -y yad

# Feh for i3 wallpapers
echo "${green}${bold}INSTALLING I3 WALLPAPER APP${reset}"
sudo dnf install -y feh

# Rofi menu for i3
echo "${green}${bold}INSTALLING ROFI. I3 MENU${reset}"
sudo dnf install -y rofi

# Picom for 13  compositor for X
echo "${green}${bold}INSTALLING PICOM. I3 WINDOWS COMPOSITOR${reset}"
sudo dnf install -y picom

# Dunst i3 notifications
echo "${green}${bold}INSTALLING DUNST. I3 NOTIFICATIONS${reset}"
sudo dnf install -y dunst 

# Numlockx for i3 - numlock on at startup
echo "${green}${bold}INSTALLING NUMLOCKX. NUMLOCK ON AT STARTUP OF SYSTEM${reset}"
sudo dnf install -y numlockx

# Caffeine-ng for temporarily inhibits the screensaver and sleep mode. 
#echo "${green}${bold}${reset}"
#sudo dnf install -y python-click  python-setproctitle python-wheel python-pyxdg
#pip install ewmh
#cd ~/.gc
#git clone https://github.com/caffeine-ng/caffeine-ng.git
#cd caffeine-ng
#python setup.py build
#sudo python setup.py install
#sudo glib-compile-schemas /usr/share/glib-2.0/schemas
#sudo rm  /usr/share/applications/caffeine-preferences.desktop  

# Polybar Spotify 
echo "${green}${bold}INSTALLING POLYBAR SPOTIFY APPLET${reset}"
cd ~/.gc
git clone https://github.com/Jvanrhijn/polybar-spotify.git
cd

# Gnome-polkit - dispaly popup fot password for sudo 
echo "${green}${bold}INSTALLING GNOME POLKIT. POPUP WITH PASSWORD OF SUDO${reset}"
sudo dnf install -y polkit-gnome

# Zenkit
echo "${green}${bold}INSTALLING ZENKIT. KANBAN APP${reset}"
cd ~/.gc
wget https://static.zenkit.com/downloads/desktop-apps/base/zenkit-base-linux.rpm
sudo rpm -i zenkit-base-linux.rpm 
rm zenkit-base-linux.rpm
cd

# Dropbox
echo "${green}${bold}INSTALLING DROPBOX${reset}"
sudo dnf inStall -y dropbox

############ FLATPKACKS #####################

# Flathub
echo "${green}${bold}iNSTALLING FLATHUB. FLATPAK SOFTWARE SHOP${reset}"
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# Spotify
echo "${green}${bold}INSTALLING SPOTIFY${reset}"
flatpak install -y flathub com.spotify.Client

# Github desktop
echo "${green}${bold}INSTALLING GITHUB DESKTOP APP${reset}"
flatpak install -y flathub io.github.shiftey.Desktop

# Joplin
echo "${green}${bold}INSTALLING JOPLIN. NOTING APP${reset}"
flatpak install -y flathub net.cozic.joplin_desktop
mkdir -p ~/.config/joplin-desktop/plugins
cd ~/.config/joplin-desktop/plugins
wget https://github.com/joplin/plugins/raw/master/plugins/ylc395.betterMarkdownViewer/plugin.jpl -O ylc395.betterMarkdownViewer.jpl
wget https://github.com/joplin/plugins/raw/master/plugins/com.eliasvsimon.email-note/plugin.jpl -O com.eliasvsimon.email-note.jpl
wget https://github.com/joplin/plugins/raw/master/plugins/com.lki.homenote/plugin.jpl -O com.lki.homenote.jpl
wget https://github.com/joplin/plugins/raw/master/plugins/joplin.plugin.note.tabs/plugin.jpl -O joplin.plugin.note.tabs.jpl
wget https://github.com/joplin/plugins/raw/master/plugins/joplin.plugin.benji.persistentLayout/plugin.jpl -O joplin.plugin.benji.persistentLayout.jpl
cd

# GTK Gruvbox theme
echo "${green}${bold}INSTALLING GRUVBOX THEME${reset}"
cd ~/.gc
git clone https://github.com/pietryszak/gruvbox-material-gtk.git
cd gruvbox-material-gtk
mkdir -p ~/.local/share/themes/
cp -r themes/* ~/.local/share/themes/
mkdir -p ~/.themes
cp -r themes/* ~/.themes
cd
sudo flatpak override --filesystem=$HOME/.themes
sudo flatpak override --env=GTK_THEME=Gruvbox-Material-Dark

# Sensors
echo "${green}${bold}INSTALLING SENSORS APP AND FINDING ALL SENSORS IN SYSEM. IT'S TAKE A TIME. PLEASE WAIT!${reset}"
sudo dnf install -y lm_sensors
yes | sudo sensors-detect

# My dotfiles
echo "${green}${bold}COPY ALL MY DOTFILES TO PROPER FOLDERS${reset}"
cd ~/.gc
git clone https://github.com/pietryszak/dotfiles.git
cd

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

# Copy spotifyd config to proper folder
\cp -r ~/.gc/dotfiles/spotifyd ~/.config

# Copy spotify-tui config to proper folder
\cp -r ~/.gc/dotfiles/spotify-tui ~/.config

# Copy VirtualBox config to proper folder 
\cp -r ~/.gc/dotfiles/VirtualBox ~/.config
chmod +x ~/.config/VirtualBox/update.sh

# Copy VmWare config to proper folder
mkdir ~/.vmware
\cp -r ~/.gc/dotfiles/vmware/preferences ~/.vmware

# Copy Caprine config to proper folder
\cp -r ~/.gc/dotfiles/Caprine ~/.config

# Copy zsh sripts to proper folder
\cp -r ~/.gc/dotfiles/zsh/scripts/* ~/.oh-my-zsh/custom

# Copy zshrc config to proper folder
\cp -r ~/.gc/dotfiles/zsh/.zshrc ~/

# Copy powerlevel10k config to proper folder
\cp -r ~/.gc/dotfiles/zsh/.p10k.zsh ~/

# Copy terminator config to proper folder
\cp -r ~/.gc/dotfiles/terminator/ ~/.config

# Copy kitty config to proper folder
\cp -r ~/.gc/dotfiles/kitty/ ~/.config

# Copy TeamViewer config to proper folder
\cp -r ~/.gc/dotfiles/teamviewer/ ~/.config

# Copy Redshift config to proper folder
\cp -r ~/.gc/dotfiles/redshift/ ~/.config

# Copy Redshift config to proper folder
\cp -r ~/.gc/dotfiles/joplin/* ~/.config/joplin-desktop

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

# Copy arandr config to to proper folder
mkdir ~/.screenlayout
\cp -r ~/.gc/dotfiles/screenlayout/* ~/.screenlayout
chmod +x ~/.screenlayout/*

# Copy shortcuts list to proper folder
\cp -r ~/.gc/dotfiles/shortcuts ~/.config

# Copy i3 config to to proper folder
\cp -r ~/.gc/dotfiles/i3 ~/.config
rm ~/.config/i3/scripts/vmware-workspaces
rm ~/.config/i3/scripts/virtualbox-workspaces

# Copy polybar config to to proper folder
\cp -r ~/.gc/dotfiles/polybar ~/.config
chmod +x ~/.config/polybar/cuts/scripts/launcher.sh
chmod +x ~/.config/polybar/cuts/scripts/powermenu.sh
chmod +x ~/.config/polybar/scripts/*
cp ~/.gc/polybar-spotify/spotify_status.py ~/.config/polybar/scripts/
sed -i -e '/play_pause/s/25B6/F909/' ~/.config/polybar/scripts/spotify_status.py 
sed -i -e '/play_pause/s/23F8/F8E3/' ~/.config/polybar/scripts/spotify_status.py 

# Copy volumeicon config to to proper folder
\cp -r ~/.gc/dotfiles/volumeicon/* ~/.config/volumeicon

# Copy bpytop config to to proper folder
\cp -r ~/.gc/dotfiles/bpytop/* ~/.config/bpytop/

# Copy update script to to proper folder
mkdir ~/.scripts
\cp -r ~/.gc/dotfiles/update/* ~/.scripts
chmod +x ~/.scripts/update.sh

# Copy caffeine-ng config to to proper folder
#\cp -r ~/.gc/dotfiles/caffeine/* ~/.config/caffeine

# My FF profile public
echo "${green}${bold}COPY FIREFOX PROFILE WITH ADDONS AN THEME${reset}"
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
echo "${green}${bold}COPY THUNDERBIRD PROFILE WITH ADDONS AN THEME${reset}"
cd ~/.gc/dotfiles
wget https://sysoply.pl/download/public/thunderbird-profile-public.7z
7z x thunderbird-profile-public.7z
\cp -r .thunderbird ~/

# My Thunderbird cache public
cd ~/.gc/dotfiles
wget https://sysoply.pl/download/public/thunderbird-cache-public.7z
7z x thunderbird-cache-public.7z
\cp -r thunderbird ~/.cache
cd

# Remove apps 
echo "${green}${bold}REMOVE UNNECESSARY APPS${reset}"
sudo dnf remove -y gnome-terminal

# Last update
echo "${green}${bold}UPDATE SYSTEM BEFORE RESTART${reset}"
sudo dnf upgrade --refresh
sudo dnf upgrade -y
sudo dnf autoremove -y

# Sudo timeout back to default
echo "${green}${bold}SET SUDO TIMEOUT TO DEFAULT${reset}"
sudo sed -i 's/Defaults        env_reset,timestamp_timeout=60/#Defaults        env_reset,timestamp_timeout=60/g' /etc/sudoers

# Reboot
echo "${MAGENTA}${bold}INSTALLATION SUCCESFULL !! REBOOT SYSTEM${reset}"
sudo reboot