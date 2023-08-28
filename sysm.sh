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
    echo "5. Change DNS servers"
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

# Function to change DNS servers
change_dns_servers() {
    echo "Choose a DNS server preset:"
    echo "1. Google DNS (8.8.8.8, 8.8.4.4)"
    echo "2. Quad9 DNS (9.9.9.9, 149.112.112.112)"
    echo "3. Cloudflare DNS (1.1.1.1, 1.0.0.1)"
    read -p "Enter your choice (1-3): " dns_choice

    case "$dns_choice" in
        1)
            primary_dns="8.8.8.8"
            secondary_dns="8.8.4.4"
            ;;
        2)
            primary_dns="9.9.9.9"
            secondary_dns="149.112.112.112"
            ;;
        3)
            primary_dns="1.1.1.1"
            secondary_dns="1.0.0.1"
            ;;
        *)
            echo "Invalid choice."
            return
            ;;
    esac

    sudo tee /etc/resolv.conf > /dev/null << EOF
nameserver $primary_dns
nameserver $secondary_dns
EOF

    print_colored_message "DNS servers changed to $primary_dns and $secondary_dns"
    read -p "Do you want to check the new DNS servers? (y/n): " check_dns_choice
    if [ "$check_dns_choice" == "y" ] || [ "$check_dns_choice" == "Y" ]; then
        check_dns
    fi
}

# Function to check DNS servers
check_dns() {
    print_colored_message "Checking DNS servers..."
    nslookup google.com $primary_dns
    nslookup google.com $secondary_dns
}

# Main menu loop
while true; do
    show_welcome_menu
    read -p "Enter your choice (0-5): " user_choice

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
        5)
            change_dns_servers
            ;;
        0)
            echo "Exiting. Have a great day!"
            exit 0
            ;;
        *)
            echo "Invalid choice. Please enter a valid option (0-5)."
            ;;
    esac

    if [ "$user_choice" -ne 5 ]; then
        read -p "Press Enter to continue..."
    fi
done
