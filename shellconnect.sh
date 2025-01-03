#!/bin/bash

function valid_ip_format() {
	local ip=$1
	if [[ $ip =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
		return 0
	else
		return 1
	fi
}

echo -n "Enter target IP:  "
read NC_HOST

if ! valid_ip_format $NC_HOST; then
	echo "Error: Invalid IP address."
	exit 1
fi

NC_PORT="611"

echo "[*] Trying to connect with ${NC_HOST}:${NC_PORT}"

nc ${NC_HOST} ${NC_PORT}

echo "[*] Connection closed."
