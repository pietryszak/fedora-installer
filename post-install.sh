# My dotfiles
cd ~/.gc/
mkdir -p myconfig
cd myconfig
git clone https://github.com/pietryszak/dotfiles.git
cd dotfiles 
cd 

# Sensors
sudo dnf install -y lm_sensors
echo " 
############################################################################################################################################

# FINDING SENSORS. IT'S TAKE A TIME. PLEASE WAIT !

############################################################################################################################################
"
yes | sudo sensors-detect

# Spotify part 2

echo " 
############################################################################################################################################

# INSTALLING PACKAGE. IT'S TAKE A TIME. PLEASE WAIT ! TO CONTINUE PRESS q !!

############################################################################################################################################
"
yes | DISPLAY= lpf update

# Oh-my-zsh
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Oh-my-zsh addons
cd ~/.config/oh-my-zsh/custom/plugins
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# Reboot
sudo reboot
