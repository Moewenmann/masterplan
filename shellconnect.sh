#!/bin/bash

NC_PORT="611"

valid_ip_format() {
	local ip=$1
	local valid_ip_regex='^([0-9]{1,3}\.){3}[0-9]{1,3}$'

	if [[ $ip =~ $valid_ip_regex ]]; then
		for octet in $(echo $ip | tr '.' ' '); do
			if ((octet < 0 || octet > 255)); then
				return 1
			fi
		done
		return 0
	else
		return 1
	fi
}

check_host() {
	local ip=$1
	nc -z -w 3 ${ip} ${NC_PORT} 2>/dev/null
	return $?
}

main_select() {
	while true; do
		echo "	:: shellconnect ::"
		echo "(1) - Connect using IP"
		echo "(2) - Connect using seat number"
		echo "(0) - Exit"
		read -p "choose an option:  " c

		case $c in
			1)
				connect_w_ip
				;;
			2)
				echo "[i] Feature not supported yet."
				connect_w_ip
				;;
			0)
				exit 0
				;;
			*)
				echo "invalid."
				;;
		esac
	done
}

connect_w_ip() {
	while true; do
		read -p "Enter target IP:  " ip
		if valid_ip_format $ip; then
			if check_host $ip; then
				echo "[i] Host reachable!"
				mode_menu $ip
			else
				echo "[!] Host not reachable!"
				mode_menu $ip
				exit 1
			fi
		else
			echo "[!] Invalid IP format!"
		fi
	done
}

mode_menu() {
	local ip=$1
	while true; do
		echo "	:: shellconnect - $ip ::"
		echo "(1) - Connect to reverse shell"
		echo "(2) - Execute scripts using reverse shell"
		echo "(0) - Exit"
		read -p "choose an option:  " c

		case $c in
			1)
				echo "	:: shellconnect - shell@$ip:$NC_PORT ::"
				nc ${ip} ${NC_PORT}
				;;
			2)
				script_execution
				;;
			0)
				return
				;;
			*)
				echo "invalid."
				;;
		esac
	done
}

script_execution() {
	while true; do
		echo "	:: shellconnect - script@$ip:$NC_PORT ::"
		echo "(00) - Go back"
		echo "(0) - Exit"
		read -p "choose an option:  " c

		case $c in
			00)
				return
				;;
			0)
				exit 0
				;;
			*)
				echo "invalid."
				;;
		esac
	done
}

main_select
