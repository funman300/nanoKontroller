#!/usr/bin/env bash

# Define variables
systemd_user_dir="$HOME/.config/systemd/user"
service_file="nanoKontroller.service"
config_file="nanoKontroller.ini"
package_manager="paru"  # Set your package manager here (e.g., pacman, apt, dnf)

# Install required packages
sudo "$package_manager" -S --noconfirm python-mido python-rtmidi python-uinput python-evdev python-pulsectl

# Create systemd user directory if it doesn't exist
mkdir -p "$systemd_user_dir"

# Copy service file to systemd user directory
cp "$service_file" "$systemd_user_dir/"

# Copy config file to ~/.config/
cp "$config_file" "$HOME/.config/"

# Copy files with sudo permissions
sudo cp uinput.conf /etc/modules-load.d/
sudo cp 01-uinput-permission.rules /etc/udev/rules.d/

# Enable and start the service
systemctl --user enable --now "$service_file"

echo "Installation completed. Please reboot to use the device."
