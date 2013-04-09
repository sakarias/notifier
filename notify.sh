#!/bin/bash

source settings.conf

function notify {

	/usr/local/bin/beengone 5 >/dev/null

	if [ $? -eq 1 ];
		then
			/Applications/terminal-notifier.app/Contents/MacOS/terminal-notifier -message "${1}" >/dev/null
		else
			curl -s \
				-F "token=${pushover_token}" \
  				-F "user=${pushover_user}" \
  				-F "message=${1}" \
  				https://api.pushover.net/1/messages.json  >/dev/null
	fi
}

notify "${1}"