# Replace polybar config for VmWare
rm ~/.config/polybar/cuts/config.ini
mv ~/.config/polybar/cuts/vmware-config.ini ~/.config/polybar/cuts/config.ini

# Replace i3-gaps workspaces for VmWare
rm ~/.config/i3/scripts/workspaces
mv ~/.gc/dotfiles/i3/scripts/vmware-workspaces ~/.config/i3/scripts/workspaces

# Replace screen layout
rm -rf ~/.screenlayout/*
cp -r ~/.gc/dotfiles/screenlayout/vmware.sh ~/.screenlayout/
chmod +x ~/.screenlayout/*
sudo reboot
