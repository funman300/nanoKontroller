#!/usr/bin/env bash

# Install required packages
yay -S --noconfirm python-mido python-rtmidi python-uinput python-evdev python-pulsectl

# Create systemd user directory if it doesn't exist
systemd_user_dir="$HOME/.config/systemd/user"
mkdir -p "$systemd_user_dir"

# Copy service file
cp nanoKontroller.service "$systemd_user_dir/"

# Copy nanoKontroller.ini to ~/.config
cp nanoKontroller.ini "$HOME/.config/"

# Copy files with sudo permissions
sudo cp uinput.conf /etc/modules-load.d/
sudo cp 01-uinput-permission.rules /etc/udev/rules.d/

# Enable the service
systemctl --user enable nanoKontroller.service

echo "Please reboot to use the device"
