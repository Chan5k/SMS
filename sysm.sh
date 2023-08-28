#!/bin/bash

# Display a welcome message
echo "System Maintenance Script"

# Update package information and upgrade installed packages
sudo apt update
sudo apt upgrade -y

# Clean up unnecessary packages and old versions
sudo apt autoremove -y
sudo apt autoclean

# Clean up temporary files
sudo rm -rf /tmp/*

# Check disk space usage
df -h

# Display a completion message
echo "System maintenance complete."
