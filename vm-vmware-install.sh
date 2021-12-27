# Replace polybar config for VmWare
rm ~/.config/polybar/cuts/config.ini
mv ~/.config/polybar/cuts/vmware-config.ini ~/.config/polybar/cuts/config.ini

# Replace i3-gaps workspaces for VmWare
rm ~/.config/i3/scripts/workspaces
mv ~/.config/i3/scripts/vmware-workspaces ~/.config/i3/scripts/workspaces

# Replace kitty to terminator
sudo sed -i 's/bindsym $mod+Return exec --no-startup-id kitty/bindsym $mod+Return exec --no-startup-id terminator --no-dbus/g' ~/.config/i3/scripts/bindings
