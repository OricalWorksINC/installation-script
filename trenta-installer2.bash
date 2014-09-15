#!/bin/bash
echo "Configuring Trenta More..."
gsettings set org.gnome.desktop.interface document-font-name 'Roboto 11'
gsettings set org.gnome.desktop.interface font-name 'Roboto 11'
gsettings set org.gnome.desktop.interface monospace-font-name 'Droid Sans Mono 11'
gsettings set org.gnome.nautilus.desktop font 'Roboto 11'
# Setting system themes
gsettings set org.gnome.desktop.interface gtk-theme "Rainier"
gsettings set org.gnome.desktop.interface icon-theme 'Rainier'
gsettings set org.gnome.desktop.wm.preferences theme "Rainier"
# Configure Docky
pkill docky
gconftool-2 -s -t string /apps/docky-2/Docky/Services/ThemeService/Theme Rainier
gconftool-2 -s -t string /apps/docky-2/Docky/Interface/DockPreferences/Dock1/Autohide Intellihide
gconftool-2 --type list --list-type string --set /apps/docky-2/Docky/Interface/DockPreferences/Dock1/Launchers '[file:///usr/share/applications/midori.desktop,file:///usr/share/applications/nautilus.desktop,/usr/share/applications/vlc.desktop,file:///usr/share/applications/musique.desktop,file:///usr/share/applications/libreoffice-startcenter.desktop,file:///usr/share/applications/ubuntu-software-center.desktop,file:///usr/share/applications/gnome-terminal.desktop,file:///usr/share/applications/unity-control-center.desktop]' 
gconftool-2 --type list --list-type string --set /apps/docky-2/Docky/Interface/DockPreferences/Dock1/Plugins '[Mounter,Trash]'
gconftool-2 -s -t boolean /apps/docky-2/Docky/Interface/DockPreferences/Dock1/ThreeDimensional true
gconftool-2 --type Boolean --set /apps/docky-2/Docky/Items/DockyItem/ShowDockyItem False
gsettings set org.gnome.desktop.background picture-uri "file:///usr/share/backgrounds/trenta-wallpaper.png"
# Cleaning Up
echo "Cleaning Up..."
sudo rm -rf ~/.trenta/installer
echo "Now, we need you configure Gnome Panel yourself. We'll walk you through it."
notify-send --urgency=critical --app-name=gnome-terminal --icon=trenta Trenta\ OS The\ installer\ needs\ some\ attention!
zenity --info --icon-name=trenta --text="Now, we need you configure Gnome Panel yourself. We'll walk you through it."
zenity --info --icon-name=trenta --text="First, mouse over the bottom panel and while holding the [Super (Windows)] key and [Alt], right click the panel. Then select {Delete this Panel}."
zenity --info --icon-name=trenta --text="Next, while holding the [Super (Windows)] key and [Alt], right click the word {Applications} in the top panel. Then select {Remove from Panel}."
zenity --info --icon-name=trenta --text="Then, while holding the [Super (Windows)] key and [Alt], right click the created empty space in the top panel. Then select {Add to Panel}."
zenity --info --icon-name=trenta --text="Finally, select {Application Launcher}. Then open Accessories and select Slingscold."
zenity --info --icon-name=trenta --text="Now locate the dock at the bottom of the screen. Side the Terminal icon to the left of the Settings icon."
# Completion
echo "Trenta has completed installation!"
notify-send --urgency=critical --app-name=gnome-terminal --icon=trenta Trenta\ OS Trenta\ has\ completed\ installation!
zenity --info --icon-name=trenta --text="Trenta has completed installation! Once you close this window, Trenta will restart. Please save your work and hit OK."
sudo reboot -f
exit
