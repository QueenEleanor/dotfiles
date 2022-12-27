#!/bin/bash
fail() {
  echo "[*] Installation Failed. Try again"
  exit -1
}

echo -n "Start system configuration? [y/N] "
read option
if [[ !($option == "y" || $option == "Y" || $option == "yes") ]]; then
  echo "Cancelled system configurtion"
  exit 0
fi
echo "[*] Starting system configuration..."

echo "[+] installing git..."
sudo pacman -S --needed git || fail

if [[ $(yay --version &> /dev/null || echo "not found") == "not found" ]]; then
  echo "[+] Installing YAY..."
  tmp_dir=$(mktemp -d)
  git clone https://aur.archlinux.org/yay.git $tmp_dir/ || fail
  (cd $tmp_dir/ && makepkg --noconfirm -si)
  rm -rf $tmp_dir/
fi

echo "[+] Installing packages..."
yay -Syy --noconfirm || fail
yay -S   --noconfirm --needed \
  rsync sudo pulseaudio pamixer lightdm lightdm-gtk-greeter \
  i3-gaps i3blocks i3lock rofi flameshot picom feh \
  ttf-font-awesome rxvt-unicode zsh btop ranger neovim firefox discord \
  || fail

echo "[+] Copying configs..."
script_dir=$(cd  $(dirname -- "${BASH_SOURCE[0]}") && pwd)
sudo rsync -a $script_dir/ $HOME/

echo "[+] Updating repository submodules..." 
(cd $HOME && git submodule init)
(cd $HOME && git submodule update --recursive)

echo "[+] Setting up window manager..."
sudo systemctl enable lightdm.service

echo "[+] Setting up shell..."
xrdb $HOME/.Xresources
sudo chsh -s /bin/zsh $(whoami)
(cd $HOME && pwd) > $HOME/.cache/saved_wd
mkdir -p $HOME/.cache/zsh/
touch $HOME/.cache/zsh/history

echo "[+] Setting up gdb..."
(cd $HOME/.config/pwndbg && ./setup.sh) || failed="true"
git restore $HOME/.gdbinit
if [[ $failed == "true" ]]; then
  fail;
fi

echo "[*] System configuration complete"

echo -n "A reboot is required for some changes to apply. Reboot now? [y/N] "
read option
if [[ ($option == "y" || $option == "Y" || $option == "yes") ]]; then
  sudo reboot
fi
