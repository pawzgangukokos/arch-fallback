#!/bin/bash

set -e


#Pełna aktualizacja pakietów pacmana
echo "Aktualizacja systemu"
sudo pacman -Syu --noconfirm


#Instalacja pakietów do buowy pakietu z AUR
echo "Instalacja podstawowych pakietów"
sudo pacman -S --needed --noconfirm git base-devel


#Instalacja YAY
if ! command -v yay &> /dev/null; then
    echo "[+] Instalacja yay (AUR helper)"

    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm
    cd ..
    rm -rf yay
fi


#Instalacja listy pakietów pacmana
echo "Instalowanie pakietów z pacmana zapisanych na pacmanlist.txt"
sudo pacman -S --needed --noconfirm - < pacmanlist.txt


#Instalacja listy pakietów AUR
echo "Instalacja pakietów z AUR zapisanych w aurlist.txt
yay -S --needed --noconfirm -< aurlist.txt


#Kopia configów do ~/.config/
echo "Kopiowanie configów do ~/.config/
cp -r ./configi/* ~/.config


#Usługi systemctl
sudo systemctl enable NetworkManager 2>/dev/null || true
sudo systemctl enable lightdm 2>/dev/null || true


#Zmiana shela
chsh -s /usr/bin/fish
fish -c "set -U fish_color_user cyan" 2>/dev/null || true
fish -c "set -U fish_greeting "" " 2>/dev/null || true


#Motywy
echo "Kopiowanie motywów"
sudo cp -r ./themes/* /usr/share/themes
sudo cp ./themes/* /usr/share/themes


#Fonty
echo "Kopiowanie fontów"
sudo cp -r ./fonts/* /usr/share/fonts
sudo cp ./fonts/* /usr/share/fonts


#Ikonki
echo "Kopiowanie ikonek"
sudo cp -r ./icons/* /usr/share/icons
sudo cp ./icons/* /usr/share/icons


#ZAKOŃCZENIE
echo "Koniec piku, zalecany jest restart systemu!!!"
