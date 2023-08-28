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
    echo "5. Check disk space usage"
    echo "0. Exit"
    echo "====================================="
}

# Main menu loop
while true; do
    show_welcome_menu
    read -p "Enter your choice (0-5): " user_choice

    case "$user_choice" in
        1)
            sudo apt update
            print_colored_message "Package information updated."
            ;;
        2)
            sudo apt upgrade -y
            print_colored_message "Installed packages upgraded."
            ;;
        3)
            sudo apt autoremove -y
            print_colored_message "Unnecessary packages removed."
            ;;
        4)
            sudo rm -rf /tmp/*
            print_colored_message "Temporary files cleaned up."
            ;;
        5)
            df -h
            print_colored_message "Disk space usage checked."
            ;;
        0)
            echo "Exiting. Have a great day!"
            exit 0
            ;;
        *)
            echo "Invalid choice. Please enter a valid option (0-5)."
            ;;
    esac

    read -p "Press Enter to continue..."
done
