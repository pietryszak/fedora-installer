#!/bin/bash

############################################################################################################################################

# Fedora i3-gaps installer sysoply.pl Paweł Pietryszak 2021

############################################################################################################################################
touch ~/.gc/fedora-installer/install-log

# Echo colors
magenta=`tput setaf 5`
green=`tput setaf 2`
bold=`tput bold`
reset=`tput sgr0`

# GTK theme
echo "${green}${bold}SETTING DARK GTK THEME${reset}"
gsettings set org.gnome.desktop.interface gtk-theme "Adwaita-dark" 

# Sudo timeout
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
echo "${green}${bold}SETTING DNF FOR FASTER DOWNLOAD PACKETS${reset}"
sudo bash -c 'echo "fastestmirror=True
max_parallel_downloads=10
defaultyes=True" >> /etc/dnf/dnf.conf'
sudo sed -i 's/installonly_limit=3/installonly_limit=2/g' /etc/dnf/dnf.conf

# Remove apps 
echo "${green}${bold}REMOVE UNNECESSARY GNOME APPS${reset}"
sudo dnf remove -y gnome-maps gnome-clocks gnome-weather gnome-contacts gnome-tour totem gnome-screenshot firefox >> ~/.gc/fedora-installer/install-log

# Update system
echo "${green}${bold}UPDATE SYSTEM. IT'S TAKE TIME. PLEASE WAIT!${reset}"
sudo dnf -y upgrade >> ~/.gc/fedora-installer/install-log

# RPM Fusion - extra repo for apps not provided by Fedora or RH free and nonfree
echo "${green}${bold}ADDING RPM FUSION REPOSITORIUM FOR APPS NOT PROVIDED BY FEDORA${reset}"
sudo dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm >> ~/.gc/fedora-installer/install-log

# Add RPM Fusion to Gnome Software
echo "${green}${bold}ADDING RPM FUSION REPOSITORIUM TO SOFTWARE SHOP${reset}"
sudo dnf groupupdate -y core >> ~/.gc/fedora-installer/install-log

# Add multimedia codecs
echo "${green}${bold}ADDING MULTIMEDIA CODECS${reset}"
sudo dnf groupupdate -y multimedia --setop="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin >> ~/.gc/fedora-installer/install-log
sudo dnf groupupdate -y  sound-and-video >> ~/.gc/fedora-installer/install-log

# Audio and Video plugins
echo "${green}${bold}ADDING AUDIO AND VIDEO PLUGINS${reset}"
sudo dnf install -y gstreamer1-plugins-{bad-\*,good-\*,base} gstreamer1-plugin-openh264 gstreamer1-libav --exclude=gstreamer1-plugins-bad-free-devel >> ~/.gc/fedora-installer/install-log
sudo dnf install -y lame\* --exclude=lame-devel >> ~/.gc/fedora-installer/install-log
sudo dnf group upgrade -y --with-optional Multimedia >> ~/.gc/fedora-installer/install-log

# DVD codecs
echo "${green}${bold}ADDING DVD CODECS${reset}"
sudo dnf install -y rpmfusion-free-release-tainted >> ~/.gc/fedora-installer/install-log
sudo dnf install -y libdvdcss >> ~/.gc/fedora-installer/install-log

# Nonfree firmawre 
echo "${green}${bold}ADDING NONFREE FIRMWARE${reset}"
sudo dnf install -y rpmfusion-nonfree-release-tainted >> ~/.gc/fedora-installer/install-log
sudo dnf install -y \*-firmware >> ~/.gc/fedora-installer/install-log

# Intel multimedia codecs
echo "${green}${bold}ADDING INTEL VIDEO ACCELERATION API${reset}"
sudo dnf install -y intel-media-driver >> ~/.gc/fedora-installer/install-log
sudo dnf install -y libva-intel-driver >> ~/.gc/fedora-installer/install-log

# Codecs 
echo "${green}${bold}ADDING FFMPEG CODECS${reset}"
sudo dnf install -y ffmpeg >> ~/.gc/fedora-installer/install-log

# Mpv
echo "${green}${bold}INSTALLING MPV. VIDEO APP${reset}"
sudo dnf install -y mpv >> ~/.gc/fedora-installer/install-log

# Gnome extensions
echo "${green}${bold}INSTALLING GNOME TWEAKS${reset}"
sudo dnf install -y gnome-extensions-app >> ~/.gc/fedora-installer/install-log
sudo dnf install -y gnome-tweaks >> ~/.gc/fedora-installer/install-log
 
# Neovim
echo "${green}${bold}INSTALLING NEOVIM${reset}"
sudo dnf install -y neovim python3-neovim >> ~/.gc/fedora-installer/install-log
sudo bash -c 'echo "EDITOR=nvim" >> /etc/environment'

# Nodejs for neovim plugins
echo "${green}${bold}INSTALLING NODEJS FOR VIM PLUGINS${reset}"
sudo dnf install -y nodejs >> ~/.gc/fedora-installer/install-log

# Vim-plug
echo "${green}${bold}INSTALLING VIM-PLUG. VIM PLUGINS INSTALLER${reset}"
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim' >> ~/.gc/fedora-installer/install-log

# Bat - new cat ;)
echo "${green}${bold}INSTALLING BAT. BETTER CAT COMMAND${reset}"
sudo dnf install -y bat >> ~/.gc/fedora-installer/install-log

# Ripgrep
echo "${green}${bold}INSTALLING RIPGREP. NEW REPLECMENT FOR GREP${reset}"
sudo dnf install -y ripgrep >> ~/.gc/fedora-installer/install-log

# Most = man pager
echo "${green}${bold}INSTALLING MOST. BETTER MAN HIGHLIGHTING${reset}"
sudo dnf install -y most >> ~/.gc/fedora-installer/install-log

# Neofetch
echo "${green}${bold}INSTALLING NEOFETCH. SYSTEM INFO IN TERMINAL ${reset}"
sudo dnf install -y neofetch >> ~/.gc/fedora-installer/install-log

# Htop
echo "${green}${bold}INSTALLING HTOP. BETTER TOP COMMAND${reset}"
sudo dnf install -y htop >> ~/.gc/fedora-installer/install-log

# Bpytop
echo "${green}${bold}INSTALLING BTOP. TOP WITH MOUSE SUPPORT${reset}"
sudo dnf install -y bpytop >> ~/.gc/fedora-installer/install-log

# Nnn
echo "${green}${bold}INSTALLING NNN. FILE MANAGER IN TERMINAL${reset}"
sudo dnf install -y nnn >> ~/.gc/fedora-installer/install-log

# Thunderbird
echo "${green}${bold}INSTALLING THUNDERBIRD. MAIL CLIENT${reset}"
sudo dnf install -y thunderbird >> ~/.gc/fedora-installer/install-log

# Gimp
echo "${green}${bold}INSTALLING GIMP. GRAPHICS APP${reset}"
sudo dnf install -y gimp >> ~/.gc/fedora-installer/install-log

# Flameshot
echo "${green}${bold}INSTALLING FLAMESHOT. SCREENSHOTS APP${reset}"
sudo dnf install -y flameshot >> ~/.gc/fedora-installer/install-log

# Libreoffice draw
echo "${green}${bold}INSTALLING LIBREOFFICE DRAW FOR PDF EDITING${reset}"
sudo dnf install -y libreoffice-draw >> ~/.gc/fedora-installer/install-log

# ClamAV
echo "${green}${bold}INSTALLING CLAMAV. BEST LINUX ANTIVIRUS${reset}"
sudo dnf install -y clamav clamd clamav-update clamtk >> ~/.gc/fedora-installer/install-log
sudo setsebool -P antivirus_can_scan_system 1
sudo systemctl stop clamav-freshclam
sudo freshclam >> ~/.gc/fedora-installer/install-log
sudo freshclam >> ~/.gc/fedora-installer/install-log
sudo systemctl start clamav-freshclam
sudo systemctl enable clamav-freshclam >> ~/.gc/fedora-installer/install-log

# Firewalld GUI
echo "${green}${bold}INSTALLING FIREWALL GUI${reset}"
sudo dnf install -y firewall-config >> ~/.gc/fedora-installer/install-log

# Timeshift
echo "${green}${bold}INSTALLING TIMESHIFT. BACKUP TOOL${reset}"
sudo dnf install -y timeshift >> ~/.gc/fedora-installer/install-log

# Terminator - terminal for vm
echo "${green}${bold}INSTALLING TERMINATOR. TERMINAL FOR VIRTUALMASHINE${reset}"
sudo dnf install -y terminator >> ~/.gc/fedora-installer/install-log

# Kitty - terminal for pc
echo "${green}${bold}INSTALLING KITTY. TERMINAL FOR PC${reset}"
sudo dnf install -y kitty >> ~/.gc/fedora-installer/install-log

# Transsmision
echo "${green}${bold}INSTALLING TRANSMISSION. TORRENT APP${reset}"
sudo dnf install -y transmission >> ~/.gc/fedora-installer/install-log

# Redshift
echo "${green}${bold}INSTALLING REDSHIFT. ADJUST THE COLOR TEMPERATURE OF SCREEN${reset}"
sudo dnf install -y redshift-gtk >> ~/.gc/fedora-installer/install-log

# Kernel headers
echo "${green}${bold}INSTALLING KERNEL HEADERS. IT'S TAKE A TIME. PLEASE WAIT!${reset}"
sudo dnf install -y "kernel-devel-$(uname -r)" >> ~/.gc/fedora-installer/install-log
sudo dnf install -y dkms >> ~/.gc/fedora-installer/install-log

# Virtualbox
echo "${green}${bold}INSTALLING VIRTUALBOX${reset}"
sudo dnf install -y VirtualBox akmod-VirtualBox >> ~/.gc/fedora-installer/install-log
sudo akmods   
sudo systemctl restart vboxdrv  
lsmod  | grep -i vbox >> ~/.gc/fedora-installer/install-log
sudo usermod -a -G vboxusers $USER   
sudo modprobe vboxdrv

# Virtualbox extensions pack
echo "${green}${bold}INSTALLING VIRTUALBOX EXTENSION PACK${reset}"
cd ~/.gc
mkdir -p VirtualBox
cd VirtualBox
LatestVirtualBoxVersion=$(wget -qO - https://download.virtualbox.org/virtualbox/LATEST-STABLE.TXT) && wget "https://download.virtualbox.org/virtualbox/${LatestVirtualBoxVersion}/Oracle_VM_VirtualBox_Extension_Pack-${LatestVirtualBoxVersion}.vbox-extpack" >> ~/.gc/fedora-installer/install-log
yes | sudo VBoxManage extpack install --replace Oracle_VM_VirtualBox_Extension_Pack-${LatestVirtualBoxVersion}.vbox-extpack >> ~/.gc/fedora-installer/install-log

# Virtualbox NAT Network nad Host-only Network
echo "${green}${bold}ADDING VIRTUALBOX NAT AND HOST-ONLY NETWORKS${reset}"
VBoxManage natnetwork add --netname NatNetwork --network "10.0.2.0/24" --enable
VBoxManage hostonlyif create

# Vmware Workstation
echo "${green}${bold}INSTALLING VMWARE WORKSTATION. IT'S TAKE A TIME. PLEASE WAIT!${reset}"
cd ~/.gc
wget --user-agent="Mozilla/5.0 (X11; Fedora; Linux x86_64; rv:94.0) Gecko/20100101 Firefox/94.0" https://www.vmware.com/go/getworkstation-linux >> ~/.gc/fedora-installer/install-log
chmod a+x getworkstation-linux
sudo ./getworkstation-linux  --console --required --eulas-agreed   
sudo CPATH=/usr/src/kernels/$(uname -r)/include/linux vmware-modconfig --console --install-all >> ~/.gc/fedora-installer/install-log
rm getworkstation-linux

# Virt-manager for KVM
echo "${green}${bold}INSTALLING VIRT MANAGER FOR KVM${reset}"
sudo dnf group install -y --with-optional virtualization >> ~/.gc/fedora-installer/install-log
sudo systemctl start libvirtd
sudo systemctl enable libvirtd >> ~/.gc/fedora-installer/install-log
sudo usermod -a -G libvirt $USER 

# TeamViewer
echo "${green}${bold}INSTALLING TEAMVIEWER${reset}"
cd ~/.gc
wget https://download.teamviewer.com/download/linux/teamviewer.x86_64.rpm >> ~/.gc/fedora-installer/install-log
sudo dnf -y install ./teamviewer.x86_64.rpm >> ~/.gc/fedora-installer/install-log
rm teamviewer.x86_64.rpm
cd

# Caprine - FB messenger
echo "${green}${bold}INSTALLING CAPRINE. FACEBOOK MESSENGER APP${reset}"
sudo dnf copr enable -y dusansimic/caprine >> ~/.gc/fedora-installer/install-log
sudo dnf upgrade -y >> ~/.gc/fedora-installer/install-log 
sudo dnf install -y caprine >> ~/.gc/fedora-installer/install-log

# VSCode
echo "${green}${bold}INSTALLING VSCODE. CODING APP FROM MICROSOFT${reset}"
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc >> ~/.gc/fedora-installer/install-log
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo' >> ~/.gc/fedora-installer/install-log
sudo dnf -y check-upgrade >> ~/.gc/fedora-installer/install-log
sudo dnf install -y code >> ~/.gc/fedora-installer/install-log

# VSCode plugins
echo "${green}${bold}INSTALLING VSCODE PLUGINS${reset}"
code --install-extension visualstudioexptteam.vscodeintellicode >> ~/.gc/fedora-installer/install-log
code --install-extension ms-python.python >> ~/.gc/fedora-installer/install-log
code --install-extension esbenp.prettier-vscode >> ~/.gc/fedora-installer/install-log
code --install-extension redhat.vscode-xml >> ~/.gc/fedora-installer/install-log
code --install-extension redhat.vscode-yaml >> ~/.gc/fedora-installer/install-log
code --install-extension ms-azuretools.vscode-docker >> ~/.gc/fedora-installer/install-log 
code --install-extension xadillax.viml >> ~/.gc/fedora-installer/install-log
code --install-extension jdinhlife.gruvbox >> ~/.gc/fedora-installer/install-log
code --install-extension naumovs.color-highlight >> ~/.gc/fedora-installer/install-log 
code --install-extension nico-castell.linux-desktop-file >> ~/.gc/fedora-installer/install-log
code --install-extension xadillax.viml >> ~/.gc/fedora-installer/install-log
code --install-extension dlasagno.rasi >> ~/.gc/fedora-installer/install-log 
code --install-extension dcasella.i3 >> ~/.gc/fedora-installer/install-log
code --install-extension jonathanharty.gruvbox-material-icon-theme >> ~/.gc/fedora-installer/install-log

# Perl for fzf, Rust, Python pip
echo "${green}${bold}INSTALLING PERL, RUST. POPULAR PROGRAMMING LANGUAGES IN LINUX. FOR APPS USED IN SYSTEM${reset}"
sudo dnf install -y perl >> ~/.gc/fedora-installer/install-log
sudo dnf install -y rust cargo >> ~/.gc/fedora-installer/install-log

# Python pip, meson
echo "${green}${bold}INSTALLING PHP PIP, MESON, CMAKE, JQ. BUILD SYSTEM FOR APPS${reset}"
sudo dnf install -y python3-pip >> ~/.gc/fedora-installer/install-log
sudo dnf install -y meson >> ~/.gc/fedora-installer/install-log
sudo dnf install -y cmake >> ~/.gc/fedora-installer/install-log
sudo dnf install -y jq >> ~/.gc/fedora-installer/install-log

# 7zip
echo "${green}${bold}INSTALLING 7ZIP. ARCHIVE APP${reset}"
sudo dnf install -y p7zip p7zip-plugins >> ~/.gc/fedora-installer/install-log

# Bluez for bluetooth 
echo "${green}${bold}INSTALLING BLUEZ. BLUETOOTH PROTOCOL STACK FOR LINUX${reset}"
sudo dnf -y install bluez bluez-tools >> ~/.gc/fedora-installer/install-log
# bluetoothctl discoverable on

# Blueman for bluetooth applet
echo "${green}${bold}INSTALLING BLUEMAN. BLUETOOTH APPLET${reset}"
sudo dnf install -y blueman >> ~/.gc/fedora-installer/install-log

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
sudo dnf install -y qt5ct >> ~/.gc/fedora-installer/install-log
sudo bash -c 'echo "QT_QPA_PLATFORMTHEME=qt5ct" >> /etc/environment'

# Papirus gtk icons for gruvbox 
echo "${green}${bold}SET GTK ICONS${reset}"
cd ~/.gc
sudo wget -qO- https://git.io/papirus-icon-theme-install | sh >> ~/.gc/fedora-installer/install-log

# Papirus folders
echo "${green}${bold}SET FOLDERS COLORS${reset}"
wget -qO- https://git.io/papirus-folders-install | sh >> ~/.gc/fedora-installer/install-log
papirus-folders -C brown --theme Papirus-Dark
cd

# ZSH 
echo "${green}${bold}INSTALLING ZSH. UNIX SHELL WITH NEW FUTURES${reset}"
sudo dnf install -y util-linux-user >> ~/.gc/fedora-installer/install-log
sudo dnf install -y zsh >> ~/.gc/fedora-installer/install-log
sudo chsh -s $(which zsh) $USER >> ~/.gc/fedora-installer/install-log

# FZF
echo "${green}${bold}INSTALLING FZF. COMMAND LINE FUZY FINDER ${reset}"
cd .gc
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf >> ~/.gc/fedora-installer/install-log
yes | ~/.fzf/install >> ~/.gc/fedora-installer/install-log
cd

# Oh-my-zsh
echo "${green}${bold}INSTALLING OH MY ZSH. FRAMEWORK FOR ZSH${reset}"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended >> ~/.gc/fedora-installer/install-log

# Oh-my-zsh plugins
echo "${green}${bold}ADDING ZSH PLUGINS${reset}"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting >> ~/.gc/fedora-installer/install-log
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions >> ~/.gc/fedora-installer/install-log

# Fonts 
echo "${green}${bold}ADDING FONTS TO SYSTEM ${reset}"
sudo dnf install -y powerline-fonts >> ~/.gc/fedora-installer/install-log
sudo dnf install -y cabextract xorg-x11-font-utils >> ~/.gc/fedora-installer/install-log
cd ~/.gc
git clone https://github.com/pietryszak/fonts.git >> ~/.gc/fedora-installer/install-log
cd fonts
sudo dnf install -y msttcore-fonts-installer-2.6-1.noarch.rpm >> ~/.gc/fedora-installer/install-log
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
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k >> ~/.gc/fedora-installer/install-log

# i3-gaps
echo "${green}${bold}INSTALLING I3-GAPS${reset}"
sudo dnf install -y libxcb-devel xcb-util-keysyms-devel xcb-util-devel xcb-util-wm-devel xcb-util-xrm-devel yajl-devel libXrandr-devel startup-notification-devel libev-devel xcb-util-cursor-devel libXinerama-devel libxkbcommon-devel libxkbcommon-x11-devel pcre-devel pango-devel git gcc automake asciidoc xmlto >> ~/.gc/fedora-installer/install-log
sudo dnf install -y i3status-config libconfuse perl-AnyEvent perl-AnyEvent-I3 perl-JSON-XS perl-Types-Serialiser perl-common-sense xorg-x11-fonts-misc dmenu i3lock i3status perl-Guard perl-Task-Weaken pulseaudio-utils >> ~/.gc/fedora-installer/install-log
sudo dnf copr enable -y fuhrmann/i3-gaps >> ~/.gc/fedora-installer/install-log
sudo dnf install -y i3-gaps >> ~/.gc/fedora-installer/install-log

# i3-wifi applet
echo "${green}${bold}INSTALLING I3 WIFI APPLET${reset}"
sudo dnf install -y network-manager-applet >> ~/.gc/fedora-installer/install-log

# i3-volume applet
echo "${green}${bold}INSTALLING I3 VOLUME APPLET${reset}"
sudo dnf install -y volumeicon >> ~/.gc/fedora-installer/install-log

# i3 screen saver extension for X 
echo "${green}${bold}INSTALLING I3 SCREEN SAVER${reset}"
sudo dnf install -y xss-lock >> ~/.gc/fedora-installer/install-log

# Arandr -screen layout
echo "${green}${bold}INSTALLING ARANDR. XRANDR GUI${reset}"
sudo dnf install -y arandr >> ~/.gc/fedora-installer/install-log

# Polybar - i3 statusbar
echo "${green}${bold}INSTALLING POLYBAR. I3 BAR${reset}"
sudo dnf install -y polybar >> ~/.gc/fedora-installer/install-log

# Yad for polybar calendar
echo "${green}${bold}INSTALLING I3 CALENDAR APPLET${reset}"
sudo dnf install -y yad >> ~/.gc/fedora-installer/install-log

# Feh for i3 wallpapers
echo "${green}${bold}INSTALLING I3 WALLPAPER APP${reset}"
sudo dnf install -y feh >> ~/.gc/fedora-installer/install-log

# Rofi menu for i3
echo "${green}${bold}INSTALLING ROFI. I3 MENU${reset}"
sudo dnf install -y rofi >> ~/.gc/fedora-installer/install-log

# Picom for 13  compositor for X
echo "${green}${bold}INSTALLING PICOM. I3 WINDOWS COMPOSITOR${reset}"
sudo dnf install -y picom >> ~/.gc/fedora-installer/install-log

# Dunst i3 notifications
echo "${green}${bold}INSTALLING DUNST. I3 NOTIFICATIONS${reset}"
sudo dnf install -y dunst >> ~/.gc/fedora-installer/install-log

# Numlockx for i3 - numlock on at startup
echo "${green}${bold}INSTALLING NUMLOCKX. NUMLOCK ON AT STARTUP OF SYSTEM${reset}"
sudo dnf install -y numlockx >> ~/.gc/fedora-installer/install-log

# Polybar Spotify 
echo "${green}${bold}INSTALLING POLYBAR SPOTIFY APPLET${reset}"
cd ~/.gc
git clone https://github.com/Jvanrhijn/polybar-spotify.git
cd

# Gnome-polkit - dispaly popup fot password for sudo 
echo "${green}${bold}INSTALLING GNOME POLKIT. POPUP WITH PASSWORD OF SUDO${reset}"
sudo dnf install -y polkit-gnome >> ~/.gc/fedora-installer/install-log

# Zenkit
echo "${green}${bold}INSTALLING ZENKIT. KANBAN APP${reset}"
cd ~/.gc
wget https://static.zenkit.com/downloads/desktop-apps/base/zenkit-base-linux.rpm
sudo rpm -i zenkit-base-linux.rpm 
rm zenkit-base-linux.rpm
cd

# Dropbox
echo "${green}${bold}INSTALLING DROPBOX${reset}"
sudo dnf install -y dropbox >> ~/.gc/fedora-installer/install-log

# Vivaldi browser
sudo dnf config-manager --add-repo https://repo.vivaldi.com/archive/vivaldi-fedora.repo 
sudo dnf install -y vivaldi-stable >> ~/.gc/fedora-installer/install-log

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
wget https://github.com/joplin/plugins/raw/master/plugins/ylc395.betterMarkdownViewer/plugin.jpl -O ylc395.betterMarkdownViewer.jpl >> ~/.gc/fedora-installer/install-log
wget https://github.com/joplin/plugins/raw/master/plugins/com.eliasvsimon.email-note/plugin.jpl -O com.eliasvsimon.email-note.jpl >> ~/.gc/fedora-installer/install-log
wget https://github.com/joplin/plugins/raw/master/plugins/com.lki.homenote/plugin.jpl -O com.lki.homenote.jpl >> ~/.gc/fedora-installer/install-log
wget https://github.com/joplin/plugins/raw/master/plugins/joplin.plugin.note.tabs/plugin.jpl -O joplin.plugin.note.tabs.jpl >> ~/.gc/fedora-installer/install-log
wget https://github.com/joplin/plugins/raw/master/plugins/joplin.plugin.benji.persistentLayout/plugin.jpl -O joplin.plugin.benji.persistentLayout.jpl >> ~/.gc/fedora-installer/install-log
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
sudo dnf install -y lm_sensors >> ~/.gc/fedora-installer/install-log
yes | sudo sensors-detect >> ~/.gc/fedora-installer/install-log

# My dotfiles
echo "${green}${bold}COPY ALL MY DOTFILES TO PROPER FOLDERS${reset}"
cd ~/.gc
git clone https://github.com/pietryszak/dotfiles.git >> ~/.gc/fedora-installer/install-log
cd

# Copy bat  config to proper folder
cp -r ~/.gc/dotfiles/bat ~/.config

# Copy Code config to proper folder
cp -r ~/.gc/dotfiles/Code/settings.json ~/.config/Code/User/

# Copy htop config to proper folder 
cp -r ~/.gc/dotfiles/htop ~/.config

# Copy neofetch config to proper folder
cp -r ~/.gc/dotfiles/neofetch ~/.config

# Copy nvim config to proper folder
cp -r ~/.gc/dotfiles/nvim ~/.config

# Copy VirtualBox config to proper folder 
cp -r ~/.gc/dotfiles/VirtualBox ~/.config
chmod +x ~/.config/VirtualBox/update.sh

# Copy VmWare config to proper folder
mkdir ~/.vmware
cp -r ~/.gc/dotfiles/vmware/preferences ~/.vmware

# Copy Caprine config to proper folder
cp -r ~/.gc/dotfiles/Caprine ~/.config

# Copy zsh sripts to proper folder
cp -r ~/.gc/dotfiles/zsh/scripts/* ~/.oh-my-zsh/custom

# Copy zshrc config to proper folder
cp -r ~/.gc/dotfiles/zsh/.zshrc ~/

# Copy powerlevel10k config to proper folder
cp -r ~/.gc/dotfiles/zsh/.p10k.zsh ~/

# Copy terminator config to proper folder
cp -r ~/.gc/dotfiles/terminator/ ~/.config

# Copy kitty config to proper folder
cp -r ~/.gc/dotfiles/kitty/ ~/.config

# Copy TeamViewer config to proper folder
cp -r ~/.gc/dotfiles/teamviewer/ ~/.config

# Copy Redshift config to proper folder
cp -r ~/.gc/dotfiles/redshift/ ~/.config

# Copy Redshift config to proper folder
cp -r ~/.gc/dotfiles/joplin/* ~/.config/joplin-desktop

# Copy bash_aliases to user folder
cp -r ~/.gc/dotfiles/bashrc/.bash_aliases ~/ 

# Copy bash_aliases to sudo/root folder
sudo cp -r ~/.gc/dotfiles/bashrc/.bash_aliases /root  

# Copy qt5ct config to to proper folder
cp -r ~/.gc/dotfiles/qt5ct ~/.config

# Copy gtk config to to proper folder
cp ~/.gc/dotfiles/gtk/.gtkrc-2.0 ~
cp ~/.gc/dotfiles/gtk/settings.ini ~/.config/gtk-3.0/

# Copy gedit config to to proper folder
sudo cp -r ~/.gc/dotfiles/gedit/* /usr/share/gtksourceview-4/styles
gsettings set org.gnome.gedit.preferences.editor scheme 'gruvbox-dark' 

# Copy arandr config to to proper folder
mkdir ~/.screenlayout
cp -r ~/.gc/dotfiles/screenlayout/* ~/.screenlayout
chmod +x ~/.screenlayout/*

# Copy shortcuts list to proper folder
cp -r ~/.gc/dotfiles/shortcuts ~/.config

# Copy i3 config to to proper folder
cp -r ~/.gc/dotfiles/i3 ~/.config
rm ~/.config/i3/scripts/vmware-workspaces
rm ~/.config/i3/scripts/virtualbox-workspaces

# Copy polybar config to to proper folder
cp -r ~/.gc/dotfiles/polybar ~/.config
chmod +x ~/.config/polybar/cuts/scripts/launcher.sh
chmod +x ~/.config/polybar/cuts/scripts/powermenu.sh
chmod +x ~/.config/polybar/scripts/*
cp ~/.gc/polybar-spotify/spotify_status.py ~/.config/polybar/scripts/
sed -i -e '/play_pause/s/25B6/F909/' ~/.config/polybar/scripts/spotify_status.py 
sed -i -e '/play_pause/s/23F8/F8E3/' ~/.config/polybar/scripts/spotify_status.py 

# Copy volumeicon config to to proper folder
cp -r ~/.gc/dotfiles/volumeicon/* ~/.config/volumeicon

# Copy bpytop config to to proper folder
mkdir  ~/.config/bpytop/
cp -r ~/.gc/dotfiles/bpytop/* ~/.config/bpytop/

# Copy update script to to proper folder
mkdir ~/.scripts
cp -r ~/.gc/dotfiles/update/* ~/.scripts
chmod +x ~/.scripts/update.sh

# My Vivaldi browser profile public
echo "${green}${bold}COPY VIVALDI PROFILE WITH ADDONS AND THEME${reset}"
cd ~/.gc/dotfiles
mkdir vivaldi
cd vivaldi
wget https://sysoply.pl/download/public/vivaldi-profile-public.7z >> ~/.gc/fedora-installer/install-log
7z x vivaldi-profile-public.7z
mkdir ~/.config/vivaldi/
cp -r ~/.gc/dotfiles/vivaldi/Default ~/.config/vivaldi/

# My Thunderbird profile public
echo "${green}${bold}COPY THUNDERBIRD PROFILE WITH ADDONS AND THEME${reset}"
cd ~/.gc/dotfiles
wget https://sysoply.pl/download/public/thunderbird-profile-public.7z >> ~/.gc/fedora-installer/install-log
7z x thunderbird-profile-public.7z
cp -r .thunderbird ~/

# My Thunderbird cache public
cd ~/.gc/dotfiles
wget https://sysoply.pl/download/public/thunderbird-cache-public.7z >> ~/.gc/fedora-installer/install-log
7z x thunderbird-cache-public.7z
cp -r thunderbird ~/.cache
cd

# Remove apps 
echo "${green}${bold}REMOVE UNNECESSARY APPS${reset}"
sudo dnf remove -y gnome-terminal >> ~/.gc/fedora-installer/install-log

# Last update
echo "${green}${bold}UPDATE SYSTEM BEFORE RESTART${reset}"
sudo dnf upgrade --refresh >> ~/.gc/fedora-installer/install-log
sudo dnf upgrade -y >> ~/.gc/fedora-installer/install-log
sudo dnf autoremove -y >> ~/.gc/fedora-installer/install-log

# Sudo timeout back to default
echo "${green}${bold}SET SUDO TIMEOUT TO DEFAULT${reset}"
sudo sed -i 's/Defaults        env_reset,timestamp_timeout=60/#Defaults        env_reset,timestamp_timeout=60/g' /etc/sudoers

# Reboot
echo "${MAGENTA}${bold}INSTALLATION SUCCESFULL !! REBOOT SYSTEM${reset}"
sudo reboot