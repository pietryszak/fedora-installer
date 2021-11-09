# Oh-my-zsh addons
cd ~/.config/oh-my-zsh/custom/plugins
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

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


# Sudo timeout back to default
sudo sed -i 's/Defaults        env_reset,timestamp_timeout=60/#Defaults        env_reset,timestamp_timeout=60/g' /etc/default/grub

# Reboot
sudo reboot
