#!/bin/bash

# Update apt packages
sudo apt update && sudo apt -y full-upgrade && sudo apt -y autoremove --purge

# Update snap packages
sudo snap refresh

# Update system flatpaks
sudo flatpak update

# Update user flatpaks
flatpak update
