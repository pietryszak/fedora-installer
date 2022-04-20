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
sudo dnf remove -yq gnome-maps gnome-clocks gnome-weather gnome-contacts gnome-tour totem gnome-screenshot firefox >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log

# Update system
echo "${green}${bold}UPDATE SYSTEM. IT'S TAKE TIME. PLEASE WAIT!${reset}"
sudo dnf -yq upgrade >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log

# RPM Fusion - extra repo for apps not provided by Fedora or RH free and nonfree
echo "${green}${bold}ADDING RPM FUSION REPOSITORIUM FOR APPS NOT PROVIDED BY FEDORA${reset}"
sudo dnf install -yq https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log

# Add RPM Fusion to Gnome Software
echo "${green}${bold}ADDING RPM FUSION REPOSITORIUM TO SOFTWARE SHOP${reset}"
sudo dnf groupupdate -yq core >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log

# Add multimedia codecs
echo "${green}${bold}ADDING MULTIMEDIA CODECS${reset}"
sudo dnf groupupdate -yq multimedia --setop="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log
sudo dnf groupupdate -yq  sound-and-video >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log

# Audio and Video plugins
echo "${green}${bold}ADDING AUDIO AND VIDEO PLUGINS${reset}"
sudo dnf install -yq gstreamer1-plugins-{bad-\*,good-\*,base} gstreamer1-plugin-openh264 gstreamer1-libav --exclude=gstreamer1-plugins-bad-free-devel >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log
sudo dnf install -yq lame\* --exclude=lame-devel >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log
sudo dnf group upgrade -yq --with-optional Multimedia >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log

# DVD codecs
echo "${green}${bold}ADDING DVD CODECS${reset}"
sudo dnf install -yq rpmfusion-free-release-tainted >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log
sudo dnf install -yq libdvdcss >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log

# Nonfree firmawre 
echo "${green}${bold}ADDING NONFREE FIRMWARE${reset}"
sudo dnf install -yq rpmfusion-nonfree-release-tainted >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log
sudo dnf install -yq \*-firmware >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log

# Intel multimedia codecs
echo "${green}${bold}ADDING INTEL VIDEO ACCELERATION API${reset}"
sudo dnf install -yq intel-media-driver >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log
sudo dnf install -yq libva-intel-driver >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log

# Codecs 
echo "${green}${bold}ADDING FFMPEG CODECS${reset}"
sudo dnf install -yq ffmpeg >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log

# Mpv
echo "${green}${bold}INSTALLING MPV. VIDEO APP${reset}"
sudo dnf install -yq mpv >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log

# Gnome extensions
echo "${green}${bold}INSTALLING GNOME TWEAKS${reset}"
sudo dnf install -yq gnome-extensions-app >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log
sudo dnf install -yq gnome-tweaks >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log
 
# Neovim
echo "${green}${bold}INSTALLING NEOVIM${reset}"
sudo dnf install -yq neovim python3-neovim >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log
sudo bash -c 'echo "EDITOR=nvim" >> /etc/environment'

# Nodejs for neovim plugins
echo "${green}${bold}INSTALLING NODEJS FOR VIM PLUGINS${reset}"
sudo dnf install -yq nodejs >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log

# Vim-plug
echo "${green}${bold}INSTALLING VIM-PLUG. VIM PLUGINS INSTALLER${reset}"
sh -c 'curl -sSfLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim' >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log

# Bat - new cat ;)
echo "${green}${bold}INSTALLING BAT. BETTER CAT COMMAND${reset}"
sudo dnf install -yq bat >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log

# Ripgrep
echo "${green}${bold}INSTALLING RIPGREP. NEW REPLECMENT FOR GREP${reset}"
sudo dnf install -yq ripgrep >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log

# Most = man pager
echo "${green}${bold}INSTALLING MOST. BETTER MAN HIGHLIGHTING${reset}"
sudo dnf install -yq most >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log

# Neofetch
echo "${green}${bold}INSTALLING NEOFETCH. SYSTEM INFO IN TERMINAL ${reset}"
sudo dnf install -yq neofetch >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log

# Htop
echo "${green}${bold}INSTALLING HTOP. BETTER TOP COMMAND${reset}"
sudo dnf install -yq htop >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log

# Bpytop
echo "${green}${bold}INSTALLING BTOP. TOP WITH MOUSE SUPPORT${reset}"
sudo dnf install -yq bpytop >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log

# Nnn
echo "${green}${bold}INSTALLING NNN. FILE MANAGER IN TERMINAL${reset}"
sudo dnf install -yq nnn >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log

# Thunderbird
echo "${green}${bold}INSTALLING THUNDERBIRD. MAIL CLIENT${reset}"
sudo dnf install -yq thunderbird >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log

# Gimp
echo "${green}${bold}INSTALLING GIMP. GRAPHICS APP${reset}"
sudo dnf install -yq gimp >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log

# Flameshot
echo "${green}${bold}INSTALLING FLAMESHOT. SCREENSHOTS APP${reset}"
sudo dnf install -yq flameshot >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log

# Libreoffice draw
echo "${green}${bold}INSTALLING LIBREOFFICE DRAW FOR PDF EDITING${reset}"
sudo dnf install -yq libreoffice-draw >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log

# ClamAV
echo "${green}${bold}INSTALLING CLAMAV. BEST LINUX ANTIVIRUS${reset}"
sudo dnf install -yq clamav clamd clamav-update clamtk >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log
sudo setsebool -P antivirus_can_scan_system 1
sudo systemctl stop clamav-freshclam
sudo freshclam >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log
sudo freshclam >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log
sudo systemctl start clamav-freshclam >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log
sudo systemctl enable clamav-freshclam >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log

# Firewalld GUI
echo "${green}${bold}INSTALLING FIREWALL GUI${reset}"
sudo dnf install -yq firewall-config >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log

# Timeshift
echo "${green}${bold}INSTALLING TIMESHIFT. BACKUP TOOL${reset}"
sudo dnf install -yq timeshift >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log

# Terminator - terminal for vm
echo "${green}${bold}INSTALLING TERMINATOR. TERMINAL FOR VIRTUALMASHINE${reset}"
sudo dnf install -yq terminator >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log

# Kitty - terminal for pc
echo "${green}${bold}INSTALLING KITTY. TERMINAL FOR PC${reset}"
sudo dnf install -yq kitty >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log

# Transsmision
echo "${green}${bold}INSTALLING TRANSMISSION. TORRENT APP${reset}"
sudo dnf install -yq transmission >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log

# Redshift
echo "${green}${bold}INSTALLING REDSHIFT. ADJUST THE COLOR TEMPERATURE OF SCREEN${reset}"
sudo dnf install -yq redshift-gtk >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log

# Kernel headers
echo "${green}${bold}INSTALLING KERNEL HEADERS. IT'S TAKE A TIME. PLEASE WAIT!${reset}"
sudo dnf install -yq "kernel-devel-$(uname -r)" >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log
sudo dnf install -yq dkms >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log

# Virtualbox
echo "${green}${bold}INSTALLING VIRTUALBOX${reset}"
sudo dnf install -yq VirtualBox akmod-VirtualBox >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log
sudo akmods >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log
sudo systemctl restart vboxdrv  
lsmod  | grep -i vbox >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log
sudo usermod -a -G vboxusers $USER   
sudo modprobe vboxdrv

# Virtualbox extensions pack
echo "${green}${bold}INSTALLING VIRTUALBOX EXTENSION PACK${reset}"
cd ~/.gc
mkdir -p VirtualBox
cd VirtualBox
LatestVirtualBoxVersion=$(wget -qO - https://download.virtualbox.org/virtualbox/LATEST-STABLE.TXT) && wget -q "https://download.virtualbox.org/virtualbox/${LatestVirtualBoxVersion}/Oracle_VM_VirtualBox_Extension_Pack-${LatestVirtualBoxVersion}.vbox-extpack" >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log

# Virtualbox NAT Network nad Host-only Network
echo "${green}${bold}ADDING VIRTUALBOX NAT AND HOST-ONLY NETWORKS${reset}"
VBoxManage natnetwork add --netname NatNetwork --network "10.0.2.0/24" --enable >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log
VBoxManage hostonlyif create >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log

# Vmware Workstation
echo "${green}${bold}INSTALLING VMWARE WORKSTATION. IT'S TAKE A TIME. PLEASE WAIT!${reset}"
cd ~/.gc
wget -q --user-agent="Mozilla/5.0 (X11; Fedora; Linux x86_64; rv:94.0) Gecko/20100101 Firefox/94.0" https://www.vmware.com/go/getworkstation-linux >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log
chmod a+x getworkstation-linux
sudo ./getworkstation-linux  --console --required --eulas-agreed >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log  
sudo CPATH=/usr/src/kernels/$(uname -r)/include/linux vmware-modconfig --console --install-all >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log
rm getworkstation-linux

# Virt-manager for KVM
echo "${green}${bold}INSTALLING VIRT MANAGER FOR KVM${reset}"
sudo dnf group install -yq --with-optional virtualization >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log
sudo systemctl start libvirtd
sudo systemctl enable libvirtd >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log
sudo usermod -a -G libvirt $USER 

# TeamViewer
echo "${green}${bold}INSTALLING TEAMVIEWER${reset}"
cd ~/.gc
wget -q https://download.teamviewer.com/download/linux/teamviewer.x86_64.rpm >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log
sudo dnf -yq install ./teamviewer.x86_64.rpm >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log
rm teamviewer.x86_64.rpm
cd

# Caprine - FB messenger
echo "${green}${bold}INSTALLING CAPRINE. FACEBOOK MESSENGER APP${reset}"
sudo dnf copr enable -yq dusansimic/caprine >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log
sudo dnf upgrade -yq >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log 
sudo dnf install -yq caprine >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log

# VSCode
echo "${green}${bold}INSTALLING VSCODE. CODING APP FROM MICROSOFT${reset}"
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo' >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log
sudo dnf -yq check-upgrade >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log
sudo dnf install -yq code >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log

# VSCode plugins
echo "${green}${bold}INSTALLING VSCODE PLUGINS${reset}"
code --install-extension visualstudioexptteam.vscodeintellicode >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log
code --install-extension ms-python.python >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log
code --install-extension esbenp.prettier-vscode >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log
code --install-extension redhat.vscode-xml >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log
code --install-extension redhat.vscode-yaml >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log
code --install-extension ms-azuretools.vscode-docker >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log
code --install-extension xadillax.viml >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log
code --install-extension jdinhlife.gruvbox >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log
code --install-extension naumovs.color-highlight >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log
code --install-extension nico-castell.linux-desktop-file >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log
code --install-extension xadillax.viml >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log
code --install-extension dlasagno.rasi >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log
code --install-extension dcasella.i3 >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log
code --install-extension jonathanharty.gruvbox-material-icon-theme >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log

# Perl for fzf, Rust, Python pip
echo "${green}${bold}INSTALLING PERL, RUST. POPULAR PROGRAMMING LANGUAGES IN LINUX. FOR APPS USED IN SYSTEM${reset}"
sudo dnf install -yq perl >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log
sudo dnf install -yq rust cargo >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log

# Python pip, meson
echo "${green}${bold}INSTALLING PHP PIP, MESON, CMAKE, JQ. BUILD SYSTEM FOR APPS${reset}"
sudo dnf install -yq python3-pip >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log
sudo dnf install -yq meson >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log
sudo dnf install -yq cmake >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log
sudo dnf install -yq jq >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log

# 7zip
echo "${green}${bold}INSTALLING 7ZIP. ARCHIVE APP${reset}"
sudo dnf install -yq p7zip p7zip-plugins >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log

# Bluez for bluetooth 
echo "${green}${bold}INSTALLING BLUEZ. BLUETOOTH PROTOCOL STACK FOR LINUX${reset}"
sudo dnf -yq install bluez bluez-tools >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log
# bluetoothctl discoverable on >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log

# Blueman for bluetooth applet
echo "${green}${bold}INSTALLING BLUEMAN. BLUETOOTH APPLET${reset}"
sudo dnf install -yq blueman >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log

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
sudo dnf install -yq qt5ct >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log
sudo bash -c 'echo "QT_QPA_PLATFORMTHEME=qt5ct" >> /etc/environment'

# Papirus gtk icons for gruvbox 
echo "${green}${bold}SET GTK ICONS${reset}"
cd ~/.gc
sudo wget -qO- https://git.io/papirus-icon-theme-install | sh >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log

# Papirus folders
echo "${green}${bold}SET FOLDERS COLORS${reset}"
wget -qO- https://git.io/papirus-folders-install | sh >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log
papirus-folders -C brown --theme Papirus-Dark >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log
cd

# ZSH 
echo "${green}${bold}INSTALLING ZSH. UNIX SHELL WITH NEW FUTURES${reset}"
sudo dnf install -yq util-linux-user >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log
sudo dnf install -yq sqlite zsh >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log
sudo chsh -s $(which zsh) $USER >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log

# FZF
echo "${green}${bold}INSTALLING FZF. COMMAND LINE FUZY FINDER ${reset}"
cd .gc
git clone --quiet --depth 1 https://github.com/junegunn/fzf.git ~/.fzf >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log
yes | ~/.fzf/install >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log
cd

# Oh-my-zsh
echo "${green}${bold}INSTALLING OH MY ZSH. FRAMEWORK FOR ZSH${reset}"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log

# Oh-my-zsh plugins
echo "${green}${bold}ADDING ZSH PLUGINS${reset}"
git clone --quiet https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log
git clone --quiet https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log

# Fonts 
echo "${green}${bold}ADDING FONTS TO SYSTEM ${reset}"
sudo dnf install -yq powerline-fonts >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log
sudo dnf install -yq cabextract xorg-x11-font-utils >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log
cd ~/.gc
git clone --quiet https://github.com/pietryszak/fonts.git >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log
cd fonts
sudo dnf install -yq msttcore-fonts-installer-2.6-1.noarch.rpm >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log
mkdir -p ~/.local/share/fonts
cp feather.ttf ~/.local/share/fonts
cp iosevka_nerd_font.ttf ~/.local/share/fonts
cp MesloLGS* ~/.local/share/fonts/
cp weathericons-regular-webfont.ttf ~/.local/share/fonts
fc-cache -fv >> ~/.gc/fedora-installer/install-log
cd

# Powerlevel10k zsh
echo "${green}${bold}INSTALLING POWERLEVEL10K. ZSH THEME${reset}"
cd ~/.gc
git clone --quiet --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log

# i3-gaps
echo "${green}${bold}INSTALLING I3-GAPS${reset}"
sudo dnf install -yq libxcb-devel xcb-util-keysyms-devel xcb-util-devel xcb-util-wm-devel xcb-util-xrm-devel yajl-devel libXrandr-devel startup-notification-devel libev-devel xcb-util-cursor-devel libXinerama-devel libxkbcommon-devel libxkbcommon-x11-devel pcre-devel pango-devel git gcc automake asciidoc xmlto >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log
sudo dnf install -yq i3status-config libconfuse perl-AnyEvent perl-AnyEvent-I3 perl-JSON-XS perl-Types-Serialiser perl-common-sense xorg-x11-fonts-misc dmenu i3lock i3status perl-Guard perl-Task-Weaken pulseaudio-utils >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log
sudo dnf copr enable -yq fuhrmann/i3-gaps >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log
sudo dnf install -yq i3-gaps >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log

# i3-wifi applet
echo "${green}${bold}INSTALLING I3 WIFI APPLET${reset}"
sudo dnf install -yq network-manager-applet >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log

# i3-volume applet
echo "${green}${bold}INSTALLING I3 VOLUME APPLET${reset}"
sudo dnf install -yq volumeicon >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log

# i3 screen saver extension for X 
echo "${green}${bold}INSTALLING I3 SCREEN SAVER${reset}"
sudo dnf install -yq xss-lock >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log

# Arandr -screen layout
echo "${green}${bold}INSTALLING ARANDR. XRANDR GUI${reset}"
sudo dnf install -yq arandr >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log

# Polybar - i3 statusbar
echo "${green}${bold}INSTALLING POLYBAR. I3 BAR${reset}"
sudo dnf install -yq polybar >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log

# Yad for polybar calendar
echo "${green}${bold}INSTALLING I3 CALENDAR APPLET${reset}"
sudo dnf install -yq yad >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log

# Feh for i3 wallpapers
echo "${green}${bold}INSTALLING I3 WALLPAPER APP${reset}"
sudo dnf install -yq feh >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log

# Rofi menu for i3
echo "${green}${bold}INSTALLING ROFI. I3 MENU${reset}"
sudo dnf install -yq rofi >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log

# Picom for 13  compositor for X
echo "${green}${bold}INSTALLING PICOM. I3 WINDOWS COMPOSITOR${reset}"
sudo dnf install -yq picom >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log

# Dunst i3 notifications
echo "${green}${bold}INSTALLING DUNST. I3 NOTIFICATIONS${reset}"
sudo dnf install -yq dunst >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log

# Numlockx for i3 - numlock on at startup
echo "${green}${bold}INSTALLING NUMLOCKX. NUMLOCK ON AT STARTUP OF SYSTEM${reset}"
sudo dnf install -yq numlockx >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log

# Polybar Spotify 
echo "${green}${bold}INSTALLING POLYBAR SPOTIFY APPLET${reset}"
cd ~/.gc
git clone --quiet https://github.com/Jvanrhijn/polybar-spotify.git >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log
cd

# Gnome-polkit - dispaly popup fot password for sudo 
echo "${green}${bold}INSTALLING GNOME POLKIT. POPUP WITH PASSWORD OF SUDO${reset}"
sudo dnf install -yq polkit-gnome >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log

# Zenkit
echo "${green}${bold}INSTALLING ZENKIT. KANBAN APP${reset}"
cd ~/.gc
wget -q https://static.zenkit.com/downloads/desktop-apps/base/zenkit-base-linux.rpm >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log
sudo rpm -i zenkit-base-linux.rpm >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log
rm zenkit-base-linux.rpm
cd

# Dropbox
echo "${green}${bold}INSTALLING DROPBOX${reset}"
sudo dnf install -yq dropbox >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log

# Vivaldi browser
echo "${green}${bold}INSTALLING VIVALDI BROWSER${reset}"
sudo dnf config-manager --add-repo https://repo.vivaldi.com/archive/vivaldi-fedora.repo  >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log
sudo dnf install -yq vivaldi-stable >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log

############ FLATPKACKS #####################

# Flathub
echo "${green}${bold}iNSTALLING FLATHUB. FLATPAK SOFTWARE SHOP${reset}"
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log

# Spotify
echo "${green}${bold}INSTALLING SPOTIFY${reset}"
flatpak install -y --noninteractive flathub com.spotify.Client >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log

# Github desktop
echo "${green}${bold}INSTALLING GITHUB DESKTOP APP${reset}"
flatpak install -y --noninteractive flathub io.github.shiftey.Desktop >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log

# Joplin
echo "${green}${bold}INSTALLING JOPLIN. NOTING APP${reset}"
flatpak install -y --noninteractive flathub net.cozic.joplin_desktop >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log
mkdir -p ~/.config/joplin-desktop/plugins
cd ~/.config/joplin-desktop/plugins
wget -q https://github.com/joplin/plugins/raw/master/plugins/ylc395.betterMarkdownViewer/plugin.jpl -O ylc395.betterMarkdownViewer.jpl  >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log
wget -q https://github.com/joplin/plugins/raw/master/plugins/com.eliasvsimon.email-note/plugin.jpl -O com.eliasvsimon.email-note.jpl >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log
wget -q https://github.com/joplin/plugins/raw/master/plugins/com.lki.homenote/plugin.jpl -O com.lki.homenote.jpl >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log
wget -q https://github.com/joplin/plugins/raw/master/plugins/joplin.plugin.note.tabs/plugin.jpl -O joplin.plugin.note.tabs.jpl >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log
wget -q https://github.com/joplin/plugins/raw/master/plugins/joplin.plugin.benji.persistentLayout/plugin.jpl -O joplin.plugin.benji.persistentLayout.jpl >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log
cd

# GTK Gruvbox theme
echo "${green}${bold}INSTALLING GRUVBOX THEME${reset}"
cd ~/.gc
git clone --quiet https://github.com/pietryszak/gruvbox-material-gtk.git >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log
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
sudo dnf install -yq lm_sensors >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log
yes | sudo sensors-detect >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log

# My dotfiles
echo "${green}${bold}COPY ALL MY DOTFILES TO PROPER FOLDERS${reset}"
cd ~/.gc
git clone --quiet https://github.com/pietryszak/dotfiles.git >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log
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
wget -q https://sysoply.pl/download/public/vivaldi-profile-public.7z >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log
7z x vivaldi-profile-public.7z >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log
mkdir ~/.config/vivaldi/
cp -r ~/.gc/dotfiles/vivaldi/Default ~/.config/vivaldi/

# My Thunderbird profile public
echo "${green}${bold}COPY THUNDERBIRD PROFILE WITH ADDONS AND THEME${reset}"
cd ~/.gc/dotfiles
wget -q https://sysoply.pl/download/public/thunderbird-profile-public.7z >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log
7z x thunderbird-profile-public.7z >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log
cp -r .thunderbird ~/

# My Thunderbird cache public
cd ~/.gc/dotfiles
wget -q https://sysoply.pl/download/public/thunderbird-cache-public.7z >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log
7z x thunderbird-cache-public.7z >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log
cp -r thunderbird ~/.cache
cd

# Remove apps 
echo "${green}${bold}REMOVE UNNECESSARY APPS${reset}"
sudo dnf remove -yq gnome-terminal >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log

# Last update
echo "${green}${bold}UPDATE SYSTEM BEFORE RESTART${reset}"
sudo dnf upgrade --refresh >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log
sudo dnf upgrade -yq >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log
sudo dnf autoremove -yq >> ~/.gc/fedora-installer/install-log 2>> ~/.gc/fedora-installer/warnings-log

# Sudo timeout back to default
echo "${green}${bold}SET SUDO TIMEOUT TO DEFAULT${reset}"
sudo sed -i 's/Defaults        env_reset,timestamp_timeout=60/#Defaults        env_reset,timestamp_timeout=60/g' /etc/sudoers

# Reboot
echo "${MAGENTA}${bold}INSTALLATION SUCCESFULL !! REBOOT SYSTEM${reset}"
sudo reboot