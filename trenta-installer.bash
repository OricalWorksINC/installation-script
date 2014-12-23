#!/bin/bash
#
# Trenta OS Installer - Everyone is Welcome.
# Copyright (C) 2014 Trenta OS
# This program is free software: you can redistribute it and/or modify it under the
# terms of the GNU General Public License as published by the Free Software
# Foundation, either version 3 of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful, but WITHOUT ANY 
# WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

echo "Welcome to the Trenta OS Installer version 0.2!"
# Check if root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi
# Check if running Ubuntu 14.04.1 LTS
 if [[ $(lsb_release -si) != "Ubuntu" ]];then
    echo "Error: It appears you are not running Ubuntu 14.04.1 LTS."
    exit 1
 fi

# Check for internet connection

wget -q --tries=20 --timeout=10 http://trentaos.org -O /tmp/trentaos.idx &> /dev/null
if [ ! -s /tmp/trentaos.idx ]
then
    	wget -q --tries=20 --timeout=10 http://www.google.com -O /tmp/google.idx &> /dev/null
	if [ ! -s /tmp/google.idx ]
	then
   	 echo "No connection detected. Connect to the internet, please."
	 exit 1
	else
  	 echo "Trenta's servers appear to be down. Please try again later!"
	 exit 1
	fi
else
    echo "Internet connection detected!"
fi
echo "NOTE: If it asks you what display manager to use, be sure to select GDM!"
zenity --info --icon-name=trenta --text="Check on the script every once in a while. If it asks you what display manager to use, be sure to use your keyboard to select GDM!"
echo "Rainier Plank Theme will have an error: it's perfectly normal!"
# Start Questioning
# What Applications to Remove
echo ""
echo "This script will remove the following applications:"
echo " Firefox"
echo " Empathy"
echo " Unity"
echo " Thunderbird"
echo " Totem"
echo " Rhythmbox"

read -r -p "Are you okay with this? [Y/n] " response
response=${response,,}
if [[ $response =~ ^(yes|y| ) ]]
then
removeALL=true
else
removeALL=false
fi

if [[ $removeALL = "false" ]];
then

read -r -p "Remove Firefox? [Y/n] " response
response=${response,,}
if [[ $response =~ ^(yes|y| ) ]]
then
removeFIREFOX=true
else
removeFIREFOX=false
fi

read -r -p "Remove Empathy? [Y/n] " response
response=${response,,}
if [[ $response =~ ^(yes|y| ) ]]
then
removeEMPATHY=true
else
removeEMPATHY=false
fi

read -r -p "Remove Unity? [Y/n] " response
response=${response,,}
if [[ $response =~ ^(yes|y| ) ]]
then
removeUNITY=true
else
removeUNITY=false
fi

read -r -p "Remove Thunderbird? [Y/n] " response
response=${response,,}
if [[ $response =~ ^(yes|y| ) ]]
then
removeTHUNDERBIRD=true
else
removeTHUNDERBIRD=false
fi

read -r -p "Remove Totem? [Y/n] " response
response=${response,,}
if [[ $response =~ ^(yes|y| ) ]]
then
removeTOTEM=true
else
removeTOTEM=false
fi

read -r -p "Remove Rhythmbox? [Y/n] " response
response=${response,,}
if [[ $response =~ ^(yes|y| ) ]]
then
removeRHYTHMBOX=true
else
removeRHYTHMBOX=false
fi

fi
echo ""
# Question Media Codecs
read -r -p "Install media codecs? [Y/n] " response
response=${response,,}
if [[ $response =~ ^(yes|y| ) ]]
then
installCODECS=true
else
installCODECS=false
fi
echo ""
# Overview & Confirm
echo "Overview:"
echo " To Remove:"
if [[ $removeALL = true ]];then
echo "  Firefox"
echo "  Empathy"
echo "  Unity"
echo "  Thunderbird"
echo "  Totem"
echo "  Rhythmbox"
else
if [[ $removeFIREFOX = true ]]; then
	echo "  Firefox"
fi
if [[ $removeEMPATHY = true ]]; then
	echo "  Empathy"
fi
if [[ $removeUNITY = true ]]; then
	echo "  Unity"
fi
if [[ $removeTHUNDERBIRD = true ]]; then
	echo "  Thunderbird"
fi
if [[ $removeTOTEM = true ]]; then
	echo "  Totem"
fi
if [[ $removeRHYTHMBOX = true ]]; then
	echo "  Rhythmbox"
fi
fi

if [[ $installCODECS = true ]]; then
CODECS="Media Codecs"
fi

echo ""
echo " To Install:"
echo "  Plank"
echo "  Gnome Panel"
echo "  Rainier Theme Pack"
echo "  VLC"
echo "  Musique"
echo "  Slingscold"
echo "  Midori"
echo "  Undistract Me"
echo "  $CODECS"
echo ""
read -p "Do you want to continue (Y/n)? "
[ "$(echo $REPLY | tr [:upper:] [:lower:])" == "y" ] || exit
# Install GDM
echo "Installing GDM"
apt-get -yqq update
apt-get -yqq install gdm
apt-get -yqq purge lightdm
if [[ $removeALL = true ]];then
echo "Removing the listed applications..."
# Remove apps if All were selected
apt-get -yqq purge firefox empathy unity thunderbird totem rhythmbox docky
fi
if [[ $removeALL = false ]]; then
if [[ $removeFIREFOX = true ]]; then
Firefox=firefox
fi
if [[ $removeEMPATHY = true ]]; then
Empathy=empathy
fi
if [[ $removeUNITY = true ]]; then
Unity=unity
fi
if [[ $removeTHUNDERBIRD = true ]]; then
Thunderbird=thunderbird
fi
if [[ $removeTOTEM = true ]]; then
Totem=totem
fi
if [[ $removeRHYTHMBOX = true ]]; then
Rhythmbox=rhythmbox
fi
if [[ $installCODECS = true ]]; then
media=libavcodec-extra\ openjdk-7-jre\ icedtea-7-plugin\ flashplugin-installer\ unace\ unrar\ zip\ unzip\ p7zip-full\ p7zip-rar\ sharutils\ rar\ uudeview\ mpack\ arj\ cabextract\ file-roller\ libxine1-ffmpeg\ mencoder\ flac\ faac\ faad\ sox\ ffmpeg2theora\ libmpeg2-4\ uudeview\ libmpeg3-1\ mpeg3-utils\ mpegdemux\ liba52-dev\ mpeg2dec\ vorbis-tools\ id3v2\ mpg321\ mpg123\ libflac++6\ totem-mozilla\ icedax\ lame\ libmad0\ libjpeg-progs\ libdvdcss2\ libdvdread4\ libdvdnav4\ libswscale-extra-2\ ubuntu-restricted-extras\ gstreamer0.10-ffmpeg\ pepperflashplugin-nonfree
fi
# Remove if App Removal was Selective
echo "Removing selected applications..."
apt-get -yqq purge laptop-mode-tools docky $Firefox $Empathy $Unity $Thunderbird $Totem $Rhythmbox
fi
# Add Repos
echo "Adding Repositories..."
add-apt-repository -y ppa:trentaos-team/ppa
add-apt-repository -y ppa:trentaos-team/rainier
add-apt-repository -y ppa:libreoffice/ppa
add-apt-repository -y ppa:midori/ppa
add-apt-repository -y "deb http://archive.canonical.com/ $(lsb_release -sc) partner"
add-apt-repository -y ppa:videolan/stable-daily
add-apt-repository -y ppa:webupd8team/y-ppa-manager
add-apt-repository -y ppa:mc3man/trusty-media
add-apt-repository -y ppa:linrunner/tlp
echo 'deb http://download.videolan.org/pub/debian/stable/ /' | tee -a /etc/apt/sources.list.d/libdvdcss.list &&
echo 'deb-src http://download.videolan.org/pub/debian/stable/ /' | tee -a /etc/apt/sources.list.d/libdvdcss.list &&
wget -O - http://download.videolan.org/pub/debian/videolan-apt.asc | apt-key add -
wget -q "http://deb.playonlinux.com/public.gpg" -O- | apt-key add -
wget http://deb.playonlinux.com/playonlinux_trusty.list -O /etc/apt/sources.list.d/playonlinux.list
add-apt-repository -y main
add-apt-repository -y universe
echo "Updating Software Sources..."
# Update Repos
apt-get -yqq update
# Updating Software
echo "Updating Ubuntu..."
apt-get -yqq dist-upgrade
echo "Installing Software..."
# Start Install of Trenta Software
apt-get -yqq install fonts-roboto synapse indicator-synapse plank gnome-panel rainier-gtk-theme rainier-icon-theme rainier-plank-theme vlc musique undistract-me playonlinux midori preload process-monitor trenta-os-bootscreen y-ppa-manager gtk2-engines-murrine gtk2-engines-pixbuf tlp tlp-rdw slingscold indicator-applet-appmenu compiz-plugins compizconfig-settings-manager
# Install Codecs
echo "Installing Codecs..."
apt-get -yqq install $media
echo "Configuring Trenta..."
# Config Codecs
if [[ $installCODECS = true ]]; then
	update-pepperflashplugin-nonfree --install
	bash /usr/share/doc/libdvdread4/install-css.sh
	tlp start
fi
# Disable Apport
echo "enabled=0" > /etc/default/apport
service apport stop
# Enable Apt Progress Bar
echo 'Dpkg::Progress-Fancy "1";' > /etc/apt/apt.conf.d/99progressbar
# Set Fonts
gsettings set org.gnome.desktop.interface document-font-name 'Roboto 11'
gsettings set org.gnome.desktop.interface font-name 'Roboto 11'
gsettings set org.gnome.desktop.interface monospace-font-name 'Droid Sans Mono 11'
gsettings set org.gnome.nautilus.desktop font 'Roboto 11'
# Setting system themes
gsettings set org.gnome.desktop.interface gtk-theme "Rainier"
gsettings set org.gnome.desktop.interface icon-theme 'Rainier'
gsettings set org.gnome.desktop.wm.preferences theme "Rainier"
# Configure Docky

# Remove stolen Slingscold icon
rm -f /usr/share/icons/slingscold.png
# Edit Slingscold .desktop file
echo "[Desktop Entry]" > /usr/share/applications/slingscold.desktop
echo "Name=Slingscold" >> /usr/share/applications/slingscold.desktop
echo "Comment=Application" >> /usr/share/applications/slingscold.desktop
echo "Exec=slingscold" >> /usr/share/applications/slingscold.desktop
echo "Icon=slingscold" >> /usr/share/applications/slingscold.desktop
echo "Type=Application" >> /usr/share/applications/slingscold.desktop
echo "Categories=GNOME;GTK;Utility;" >> /usr/share/applications/slingscold.desktop
echo "StartupNotify=false" >> /usr/share/applications/slingscold.desktop
echo "Comment[en_US.UTF-8]=Application Launcher" >> /usr/share/applications/slingscold.desktop
# Create Temporary Directory to Download Files Into
mkdir -p ~/.trenta/installer
cd ~/.trenta/installer
# Download files from Trenta's Servers
wget -q http://trentaos.org/installer-files/SA2/trenta-wallpaper.png
wget -q http://trentaos.org/installer-files/SA2/ubuntu-wallpapers.xml
wget -q http://trentaos.org/installer-files/SA2/UbuntuLogo.png
wget -q http://trentaos.org/installer-files/SA2/searchingthedashlegalnotice.html
wget -q http://trentaos.org/installer-files/SA2/appearance.ui
wget -q http://trentaos.org/installer-files/SA2/process-monitor.desktop
wget -q http://trentaos.org/installer-files/SA2/synapse.desktop
wget -q http://trentaos.org/installer-files/SA2/bear.png
wget -q http://trentaos.org/installer-files/SA2/os-release
wget -q http://trentaos.org/installer-files/SA2/lsb-release
wget -q http://trentaos.org/installer-files/SA2/gnome-terminal.dockitem
wget -q http://trentaos.org/installer-files/SA2/libreoffice-startcenter.dockitem
wget -q http://trentaos.org/installer-files/SA2/midori.dockitem
wget -q http://trentaos.org/installer-files/SA2/musique.dockitem
wget -q http://trentaos.org/installer-files/SA2/nautilus.dockitem
wget -q http://trentaos.org/installer-files/SA2/ubuntu-software-center.dockitem
wget -q http://trentaos.org/installer-files/SA2/unity-control-center.dockitem
wget -q http://trentaos.org/installer-files/SA2/vlc.dockitem
# Move Downloaded Files into Place
mv -f trenta-wallpaper.png /usr/share/backgrounds
mv -f ubuntu-wallpapers.xml /usr/share/gnome-background-properties/
mv -f UbuntuLogo.png /usr/share/unity-control-center/ui
mv -f searchingthedashlegalnotice.html /usr/share/unity-control-center
mv -f appearance.ui /usr/share/unity-control-center/ui/appearance
mv -f os-release /etc
mv -f lsb-release /etc
mv -f bear.png /usr/share/icons/hicolor/96x96/apps
gtk-update-icon-cache -f /usr/share/icons/hicolor/
mv -f ~/.trenta/installer/synapse.desktop /etc/xdg/autostart
# Cleaning Up
echo "Cleaning Up..."
apt-get -f install
apt-get autoremove
apt-get -y autoclean
apt-get -y clean
# Time for part two
plank &
echo "Time for part two! Your system will restart shortly."
notify-send --urgency=critical --app-name=gnome-terminal --icon=trenta Trenta\ OS Time\ for\ part\ two!
zenity --info --icon-name=trenta --text="Please save your work and hit OK so that we can restart your system. When it boots back up, click the gear icon and select Gnome Classic (Compiz). Then login. Once you get logged in, run wget http://trentaos.org/installer-files/trenta-installer2.bash && bash trenta-installer2.bash"
reboot -f
exit
