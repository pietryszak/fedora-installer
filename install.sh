#!/bin/bash

############################################################################################################################################

# Fedora installer sysoply.pl Paweł Pietryszak 2021

############################################################################################################################################

# DNF settings
sudo bash -c 'echo "
max_parallel_downloads=10
fastestmirror=True" >> /etc/dnf/dnf.conf'

# Update system
sudo dnf update -y

# Create folders
mkdir ~/.gc
