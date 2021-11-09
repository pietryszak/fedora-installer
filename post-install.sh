# Oh-my-zsh addons
cd ~/.config/oh-my-zsh/custom/plugins
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# My dotfiles
cd ~/.gc/
mkdir -p myconfig
cd myconfig
git clone https://github.com/pietryszak/dotfiles.git

# Copy icons from dotfiles to proper folder
cd dotfiles/themes/
mkdir -p ~/.local/share/icons
tar -xf Gruvbox.tar.gz -C ~/.local/share/icons/


# Sudo timeout back to default
sudo sed -i 's/Defaults        env_reset,timestamp_timeout=60/#Defaults        env_reset,timestamp_timeout=60/g' /etc/default/grub

# Reboot
sudo reboot
