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

# INSTALLING PACKEGE. IT'S TAKE A TIME. PLEASE WAIT !

############################################################################################################################################
"
sudo -u pkg-build lpf build spotify-client 
sudo dnf install -y /var/lib/lpf/rpms/spotify-client/spotify-client-*.rpm

# Reboot
sudo reboot
