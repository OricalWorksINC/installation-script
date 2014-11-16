#!/bin/bash
# version 0.2
echo "Configuring Trenta More..."
# Set Fonts
gsettings set org.gnome.desktop.interface document-font-name 'Roboto 11'
gsettings set org.gnome.desktop.interface font-name 'Roboto 11'
gsettings set org.gnome.desktop.interface monospace-font-name 'Droid Sans Mono 11'
gsettings set org.gnome.nautilus.desktop font 'Roboto 11'
# Setting system themes
gsettings set org.gnome.desktop.interface gtk-theme "Rainier"
gsettings set org.gnome.desktop.interface icon-theme 'Rainier'
gsettings set org.gnome.desktop.wm.preferences theme "Rainier"
gsettings set org.gnome.desktop.background picture-uri "file:///usr/share/backgrounds/trenta-wallpaper.png"
# Configure Plank
sudo mv -f ~/.trenta/installer/process-monitor.desktop /etc/xdg/autostart
sudo rm -rf ~/.config/plank/dock1/launchers
sudo mkdir ~/.config/plank/dock1/launchers
sudo mv -f ~/.trenta/installer/gnome-terminal.dockitem ~/.config/plank/dock1/launchers
sudo mv -f ~/.trenta/installer/libreoffice-startcenter.dockitem ~/.config/plank/dock1/launchers
sudo mv -f ~/.trenta/installer/midori.dockitem ~/.config/plank/dock1/launchers
sudo mv -f ~/.trenta/installer/musique.dockitem ~/.config/plank/dock1/launchers
sudo mv -f ~/.trenta/installer/nautilus.dockitem ~/.config/plank/dock1/launchers
sudo mv -f ~/.trenta/installer/ubuntu-software-center.dockitem ~/.config/plank/dock1/launchers
sudo mv -f ~/.trenta/installer/unity-control-center.dockitem ~/.config/plank/dock1/launchers
sudo mv -f ~/.trenta/installer/vlc.dockitem ~/.config/plank/dock1/launchers
sudo sed -i '/Theme=/c\Theme=Rainier' ~/.config/plank/dock1/settings
sudo sed -i '/HideMode=/c\HideMode=1' ~/.config/plank/dock1/settings
sudo sed -i '/Alignment=/c\Alignment=0' ~/.config/plank/dock1/settings
sudo sed -i '/DockItems=/c\DockItems=midori.dockitem;;nautilus.dockitem;;vlc.dockitem;;musique.dockitem;;libreoffice-startcenter.dockitem;;ubuntu-software-center.dockitem;;gnome-terminal.dockitem;;unity-control-center.dockitem' ~/.config/plank/dock1/settings
# Cleaning Up
echo "Cleaning Up..."
sudo rm -rf ~/.trenta/installer
# Gnome Panel Setup
echo "Now, we need you configure Gnome Panel yourself. We'll walk you through it."
notify-send --urgency=critical --app-name=gnome-terminal --icon=gnome-terminal Trenta\ OS The\ installer\ needs\ some\ attention!
zenity --info --icon-name=gnome-terminal --text="Now, we need you configure Gnome Panel yourself. We'll walk you through it."
zenity --info --text="First, mouse over the bottom panel and while holding the [Super (Windows)] key and [Alt], right click the panel. Then select {Delete this Panel}."
zenity --info --icon-name=gnome-terminal --text="Next, while holding the [Super (Windows)] key and [Alt], right click the word {Applications} in the top panel. Then select {Remove from Panel}."
zenity --info --icon-name=gnome-terminal --text="Then, while holding the [Super (Windows)] key and [Alt], right click the created empty space in the top panel. Then select {Add to Panel}."
zenity --info --icon-name=gnome-terminal --text="Finally, select {Application Launcher}. Then open Accessories and select Slingscold."
zenity --info --icon-name=gnome-terminal --text="Now, mouse over the top panel and while holding the [Super (Windows)] key and [Alt], right click the empty space to the right of the Slingscold icon."
zenity --info --icon-name=gnome-terminal --text="Select Indicator Applet Appmenu."
sudo echo "Hidden=true" >> /usr/share/applications/slingscold.desktop
zenity --info --icon-name=gnome-terminal --text="Now, CompizConfig Settings Manager will open. Open Static Application Switcher and change Next Window (All Windows) from Ctrl-Alt-Tab to Alt-Tab. Then check the box in the left column and close the window."
ccsm
# Completion
echo "Trenta has completed installation!"
notify-send --urgency=critical --app-name=gnome-terminal --icon=trenta Trenta\ OS Trenta\ has\ completed\ installation!
zenity --info --icon-name=gnome-terminal --text="Trenta has completed installation! Once you close this window, Trenta will restart. Please save your work and hit OK."
sudo reboot -f
exit
