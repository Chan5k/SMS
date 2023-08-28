#!/bin/bash

# ANSI color codes
GREEN='\033[0;32m'
NC='\033[0m' # No Color

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

# Function to display a colored message
print_colored_message() {
    echo -e "${GREEN}$1${NC}"
}

# Ask for confirmation before each action

if confirm_action "updating package information"; then
    sudo apt update
    print_colored_message "Package information updated."
fi

if confirm_action "upgrading installed packages"; then
    sudo apt upgrade -y
    print_colored_message "Installed packages upgraded."
fi

if confirm_action "removing unnecessary packages"; then
    sudo apt autoremove -y
    print_colored_message "Unnecessary packages removed."
fi

if confirm_action "cleaning up temporary files"; then
    sudo rm -rf /tmp/*
    print_colored_message "Temporary files cleaned up."
fi

if confirm_action "checking disk space usage"; then
    df -h
    print_colored_message "Disk space usage checked."
fi

print_colored_message "System maintenance complete."
