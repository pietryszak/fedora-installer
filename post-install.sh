echo " 
############################################################################################################################################
# PLEASE PROVIDE YOUR PASSWORD !
############################################################################################################################################
"
su - $USER

# Spotify part 2

echo " 
############################################################################################################################################

# INSTALLING PACKAGE. IT'S TAKE A TIME. PLEASE WAIT ! TO CONTINUE PRESS q !!

############################################################################################################################################
"
DISPLAY= lpf update

# Oh-my-zsh addons
cd ~/.config/oh-my-zsh/custom/plugins
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# Reboot
sudo reboot
