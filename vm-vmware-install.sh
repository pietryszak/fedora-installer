# Replace polybar config for VmWare
rm ~/.config/polybar/cuts/config.ini
mv ~/.config/polybar/cuts/vm-config.ini ~/.config/polybar/cuts/config.ini

# Replace i3-gaps workspaces for VmWare
rm ~/.config/i3/scripts/workspaces
mv ~/.config/i3/scripts/vmware-workspaces ~/.config/i3/scripts/workspaces
