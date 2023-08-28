#!/bin/bash

# Display a welcome message
echo "System Maintenance Script"

# Function to ask for user confirmation
confirm_action() {
    read -p "Do you want to proceed with $1? (y/n): " choice
    case "$choice" in
        y|Y) return 0 ;;
        n|N) return 1 ;;
        *) echo "Invalid choice. Please enter y or n." ; confirm_action "$1" ;;
    esac
}

# Ask for confirmation before each action

if confirm_action "updating package information"; then
    sudo apt update
fi

if confirm_action "upgrading installed packages"; then
    sudo apt upgrade -y
fi

if confirm_action "removing unnecessary packages"; then
    sudo apt autoremove -y
fi

if confirm_action "cleaning up temporary files"; then
    sudo rm -rf /tmp/*
fi

if confirm_action "checking disk space usage"; then
    df -h
fi

echo "System maintenance complete."
