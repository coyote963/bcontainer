#!/bin/bash

install() {
	apt-get update && DEBIAN_FRONTEND=noninteractive apt-get upgrade -y
	apt-get install xvfb -y
	wget https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks
	bash winetricks sound=disabled
	apt-get install wine -y
	installbm
}

installbm() {
	wget -O bman.zip https://spasmangames.com/downloads/headless_beta15a.zip 
	unzip bman.zip -d ~/boringman
}

start() {
	Xvfb :1 -screen 0 640x480x16 -cc 4 &
        sleep 5
        mkdir ~/.wine/drive_c/users/root/'Local Settings'/'Application Data'/BoringManRewrite 
        cp /bm_server.ini ~/.wine/drive_c/users/root/'Local Settings'/'Application Data'/BoringManRewrite  
	cd ~/boringman
	xvfb-run wine ~/boringman/BoringManGame.exe -headless
}

case "$1" in
	install)	install ;;
	start)		start ;;
	*)		exit 1;;
esac
