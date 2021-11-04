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

# Reboot
sudo reboot
