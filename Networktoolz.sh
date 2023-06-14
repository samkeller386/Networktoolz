#!/bin/bash


# Update and upgrade Termux packages
pkg update && pkg upgrade


# Install necessary packages
pkg install root-repo
pkg install aircrack-ng
pkg install tsu


# Detect wireless interface name
interface=$(ip link | awk -F: '$0 !~ "lo|vir|^[^0-9]"{print $2;getline}')


# Function to start monitor mode
start_monitor_mode() {
    tsudo airmon-ng start $interface
}


# Function to stop monitor mode
stop_monitor_mode() {
    tsudo airmon-ng stop ${interface}mon
}


# Function to scan for networks
scan_networks() {
    tsudo airodump-ng ${interface}mon
}


# Main function to provide options to the user
main() {
    echo "1. Start monitor mode"
    echo "2. Stop monitor mode"
    echo "3. Scan for networks"
    echo "4. Exit"
    echo "Enter your choice:"
    read choice


    case $choice in
        1)
            start_monitor_mode
            ;;
        2)
            stop_monitor_mode
            ;;
        3)
            scan_networks
            ;;
        4)
            exit 0
            ;;
        *)
            echo "Invalid choice. Please enter a valid option."
            main
            ;;
    esac
}


# Call the main function
main