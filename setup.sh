#!/bin/bash
echo -n "Start system configuration? [y/N] "
read option
if [[ !($option == "y" || $option == "Y" || $option == "yes") ]]; then
  echo "Cancelled system configurtion"
  exit 0
fi
echo -e "Starting system configuration...\n"

git --version || (echo "Package 'git' is required to run this script" && exit -1)

echo "Installing YAY..."
TMP_DIR="$(mktemp -d)"
git clone https://aur.archlinux.org/yay.git $TMP_DIR/
(cd $TMP_DIR/ && makepkg -si)
rm -rf $TMP_DIR/

echo "Installing packages..."
yay --noconfirm -Syy 
yay --noconfirm -S 
  rsync sudo pulseaudio pamixer lightdm lightdm-gtk-greeter \
  i3-gaps i3blocks i3lock urxvt rofi gscreenshot compton feh \
  ttf-unifont ttf-roboto \
  firefox discord

echo "Copying configs..."
SCRIPT_DIR="$(cd -- $(dirname -- "${BASH_SOURCE[0]}") && pwd)"
sudo rsync -a $SCRIPT_DIR/ $HOME/

echo "Setting up window manager..."
sudo systemctl enable lightdm.service

echo -n "A reboot is required for changes to apply. Reboot now? [y/N] "
read option
if [[ !($option == "y" || $option == "Y" || $option == "yes") ]]; then
  sudo reboot
fi
