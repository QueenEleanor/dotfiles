# dotfiles
"When you live in a command line, configurations are a deeply personal thing. They are often crafted over years of experience, battles lost, lessons learned, advice followed, and ingenuity rewarded. When you are away from your own configurations, you are an orphaned refugee in unfamiliar and hostile surroundings. You feel clumsy and out of sorts. You are filled with a sense of longing to be back in a place you know. A place you built. A place where all the short-cuts have been worn bare by your own travels. A place you proudly call… $HOME."
 \- [yadm homepage](https://yadm.io/)

## Installation
There is a `setup.sh` file in the root of the repository. Run it to install all configurations and packages.
```sh
sudo pacman -S git
git clone https://github.com/QueenEleanor/dotfiles
./dotfiles/setup.sh
```
The `./dotfiles` directory can be removed after installation, since it will be copied at `$HOME`

## Updating
Simply running `git pull` will usually suffice, but running `xrdb ~/.Xresources` and restarting i3 (mod + shift + r) might be needed.

