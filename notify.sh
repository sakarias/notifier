#!/bin/bash

source settings.conf

if [ ! "${*}" ]
then
	echo "Usage: $(basename ${0}) \"message\"."
	exit 1
fi

if [[ ! "${pushover_user}" || ! "${pushover_token}" ]]
then
	echo "PushOver settings is not defined in settings.conf."
	exit 1
fi

if [ ! -x ${beengone_path} ]
then
	echo "BeenGone is missing, please install it."
	exit 1
fi

if [ ! -x "/Applications/terminal-notifier.app/Contents/MacOS/terminal-notifier" ]
then
	echo "Terminal Notifier is missing, please install it."
	exit 1
fi

function notify {
	${beengone_path} ${beengone_time} >/dev/null
	if [ $? -eq 1 ]
	then
		/Applications/terminal-notifier.app/Contents/MacOS/terminal-notifier -message "${1}" >/dev/null
	else
		curl -s \
			-F "token=${pushover_token}" \
			-F "user=${pushover_user}" \
  			-F "message=${1}" \
 			https://api.pushover.net/1/messages.json >/dev/null
	fi
}

notify "${*}"
