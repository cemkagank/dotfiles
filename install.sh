#!/bin/sh
#-----Debug-----#
green=`tput setaf 2`
reset=`tput sgr0`
yellow=`tput setaf 3`
#-----Debug-----#

#-----Programs-----#
sudo xbps-install -y zsh alacritty curl git base-devel ranger harfbuzz-devel \
    libXft-devel libXinerama-devel xorg xinit void-repo-nonfree NetworkManager \
    picom nitrogen firefox nodejs noto-fonts-emoji udiskie pcmanfm lxappearance \
    plata-theme alsa-utils alsa-lib-devel neovim dmenu
sudo xbps-install -Syu
sudo xbps-install -y nvidia
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
bash -c "cargo install rsblocks"
echo "${yellow}INFO: Installation of programs are finished${green} [DONE 1/5]${reset}"
#-----Programs-----#

#-----Config-----#
sudo rm /var/service/dhcpcd/ 
sudo ln -s /etc/sv/dbus/ /var/service/
sudo ln -s /etc/sv/NetworkManager /var/service
mkdir -pv ${HOME}/.config/alacritty
mkdir -pv ${HOME}/.config/rsblocks
sudo mkdir -pv /etc/X11/xorg.conf.d/
cp -v config_files/alacritty.yml ${HOME}/.config/alacritty/alacritty.yml 
cp -v config_files/starship.toml ${HOME}/.config/starship.toml
cp -v config_files/xinitrc ${HOME}/.xinitrc
cp -v config_files/zshrc ${HOME}/.zshrc
cp -v config_files/rsblocks.yml ${HOME}/.config/rsblocks/rsblocks.yml
sudo cp -v config_files/10-nvidia-drm-outputclass.conf /etc/X11/xorg.conf.d/10-nvidia-drm-outputclass.conf
sudo echo "blacklist pcspkr" > /etc/modprobe.d/nobeep.conf
echo "${yellow}INFO: Succesfully copied config files${green} [DONE 2/5]${reset}"
#-----Config-----#

#-----DWM-----#
sudo cp -v src/JetBrains\ Mono\ Regular\ Nerd\ Font\ Complete\ Mono.ttf /usr/share/fonts/TTF/
fc-cache
cd ~
mkdir -pv pkg
cd pkg
git clone https://github.com/cemkagank/dwm
cd dwm
sudo make install
cd ..
echo "${yellow}INFO: Succesfully installed dwm${green} [DONE 3/5]${reset}"
#-----DWM-----#

#-----nvim-----#
git clone https://github.com/cemkagank/nvim
cd nvim
./install.sh
echo "${yellow}INFO: Succesfully installed nvim${green} [DONE 4/5]${reset}"
#-----nvim-----#

#-----ZSH------#
cd ~
curl -L git.io/antigen > .antigen.zsh
sh -c "$(curl -fsSL https://starship.rs/install.sh)"
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
echo "${yellow}INFO: Succesfully installed zsh and antigen${green} [DONE 5/5]${reset}"
#-----ZSH------#
