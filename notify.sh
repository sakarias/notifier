#!/bin/bash

source settings.conf

function notify {

	if [ -x ${beengone_path} ]
		then
			${beengone_path} ${beengone_time} >/dev/null
		else
			echo "BeenGone is missing, please install it."
			exit 1
	fi

	if [ $? -eq 1 ]
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