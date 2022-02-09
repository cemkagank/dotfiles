#!/bin/sh
#-----Debug-----#
green=`tput setaf 2`
reset=`tput sgr0`
yellow=`tput setaf 3`
#-----Debug-----#

#-----Programs-----#
sudo xbps-install -y zsh alacritty curl git base-devel ranger harfbuzz-devel \
    libXft-devel libXinerama-devel xorg xinit void-repo-nonfree NetworkManager \
    picom nitrogen firefox nodejs
sudo xbps-install -Syu
sudo xbps-install nvidia
echo "${yellow}INFO: Installation of programs are finished${green} [DONE 1/3]${reset}"
#-----Programs-----#

#-----Config-----#
sudo rm /var/service/dhcpcd/ 
sudo ln -s /etc/sv/dbus/ /var/service/
sudo ln -s /etc/sv/NetworkManager /var/service
mkdir -pv ${HOME}/.config/alacritty
sudo mkdir -pv /etc/X11/xorg.conf.d/
cp -v config_files/alacritty.yml ${HOME}/.config/alacritty/alacritty.yml 
cp -v config_files/starship.toml ${HOME}/.config/starship.toml
cp -v config_files/xinitrc ${HOME}/.xinitrc
cp -v config_files/zshrc ${HOME}/.zshrc
sudo cp -v config_files/10-nvidia-drm-outputclass.conf /etc/X11/xorg.conf.d/10-nvidia-drm-outputclass.conf
echo "${yellow}INFO: Succesfully copied config files${green} [DONE 2/3]${reset}"
#-----Config-----#

#-----ZSH------#
cd ~
curl -L git.io/antigen > .antigen.zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
echo "${yellow}INFO: Succesfully installed zsh and antigen${green} [DONE 3/3]${reset}"
#-----ZSH------#
