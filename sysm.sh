#!/bin/bash

# ANSI color codes
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# Function to display a colored message
print_colored_message() {
    echo -e "${GREEN}$1${NC}"
}

# Function to show the welcome menu
show_welcome_menu() {
    clear
    echo "===== System Maintenance Script ====="
    echo "1. Update package information"
    echo "2. Upgrade installed packages"
    echo "3. Remove unnecessary packages"
    echo "4. Clean up temporary files"
    echo "0. Exit"
    echo "====================================="
}

# Function to ask for user confirmation
confirm_action() {
    read -p "Do you want to proceed with $1? (y/n): " choice
    case "$choice" in
        y|Y) return 0 ;;
        n|N) return 1 ;;
        *) echo "Invalid choice. Please enter y or n." ; confirm_action "$1" ;;
    esac
}

# Main menu loop
while true; do
    show_welcome_menu
    read -p "Enter your choice (0-4): " user_choice

    case "$user_choice" in
        1)
            if confirm_action "updating package information"; then
                sudo apt update
                print_colored_message "Package information updated."
            fi
            ;;
        2)
            if confirm_action "upgrading installed packages"; then
                sudo apt upgrade -y
                print_colored_message "Installed packages upgraded."
            fi
            ;;
        3)
            if confirm_action "removing unnecessary packages"; then
                sudo apt autoremove -y
                print_colored_message "Unnecessary packages removed."
            fi
            ;;
        4)
            if confirm_action "cleaning up temporary files"; then
                sudo rm -rf /tmp/*
                print_colored_message "Temporary files cleaned up."
            fi
            ;;
        0)
            echo "Exiting. Have a great day!"
            exit 0
            ;;
        *)
            echo "Invalid choice. Please enter a valid option (0-4)."
            ;;
    esac

    read -p "Press Enter to continue..."
done
