#!/bin/bash
echo -n "Start system configuration? [y/N] "
read option
if [[ !($option == "y" || $option == "Y" || $option == "yes") ]]; then
  echo "Cancelled system configurtion"
  exit 0
fi
echo -e "[*] Starting system configuration...\n"

if [[ $(git --version &> /dev/null || echo "not found") == "not found" ]]; then
  echo "[+] installing git..."
  sudo pacman -S git
fi

if [[ $(yay --version &> /dev/null || echo "not found") == "not found" ]]; then
  echo "[+] Installing YAY..."
  tmp_dir="$(mktemp -d)"
  git clone https://aur.archlinux.org/yay.git $tmp_dir/
  (cd $tmp_dir/ && makepkg --noconfirm -si)
  rm -rf $tmp_dir/
fi

echo "[+] Installing packages..."
yay --noconfirm -Syy 
yay --noconfirm -S \
  rsync sudo pulseaudio pamixer lightdm lightdm-gtk-greeter \
  i3-gaps i3blocks i3lock rxvt-unicode rofi gscreenshot picom feh \
  ttf-unifont ttf-roboto zsh \
  firefox discord

echo "[+] Copying configs..."
script_dir="$(cd -- $(dirname -- "${BASH_SOURCE[0]}") && pwd)"
sudo rsync -a $script_dir/ $HOME/

echo "[+] Setting up window manager..."
sudo systemctl enable lightdm.service

echo "[+] Setting up shell..."
xrdb $HOME/.Xresources
sudo chsh -s /bin/zsh $(whoami)

echo -n "A reboot is required for changes to apply. Reboot now? [y/N] "
read option
if [[ ($option == "y" || $option == "Y" || $option == "yes") ]]; then
  sudo reboot
fi
