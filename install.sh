#!/bin/bash

echo -n "Continue system configuration? [y/N] "
read option
if [[ !($option == "y" || $option == "Y" || $option == "yes") ]]; then
  echo "Cancelled system configurtion"
  exit 0
fi
echo -e "Continuing system configuration...\n"

echo "Installing packages..."
sudo pacman --noconfirm -Syy 
sudo pacman --noconfirm -S rsync lightdm lightdm-gtk-greeter i3-gaps i3blocks i3lock

echo "Copying configs..."
SCRIPT_DIR="$(cd -- $(dirname -- "${BASH_SOURCE[0]}") && pwd)"
sudo rsync -a "$HOME/" "$SCRIPT_DIR"

echo "Setting up window manager..."
sudo systemctl enable lightdm.service
