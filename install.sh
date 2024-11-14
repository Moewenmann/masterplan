#!/bin/bash

os=$(uname)

if [ -z "$USER" ]; then
	echo "No user set."
	exit 1
fi


macinstall() {
	if [[ -d ~/.oh-my-zsh ]]; then
		cp plan.sh ~/.oh-my-zsh/lib/host.zsh
		INFILE="lyfs.sh"
		OUTFILE=~/.oh-my-zsh/lib/tests/lyfs.test.zsh
		openssl enc -aes-256-cbc -salt -in "$INFILE" -out "$OUTFILE" -k "$USER"
		
	else
		echo "Der Ordner 'ozsh' ist nicht vorhanden."
	fi
}

linuxinstall() {
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