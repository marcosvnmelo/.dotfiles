#!/bin/bash

# check if arguments are passed
if [ $# -eq 0 ]; then
	echo "No arguments supplied"
	exit 1
fi

# check if the script is run as root
if [ "$(id -u)" != "0" ]; then
	echo "This script must be run as root" 1>&2
	exit 1
fi

# check if file already exists
if [ -f "go$1.linux-amd64.tar.gz" ]; then
	rm "go$1.linux-amd64.tar.gz"
	exit 1
fi

APPVER=$(/usr/local/go/bin/go version)
APPVER="${APPVER//go version go/""}"
APPVER="${APPVER// linux\/amd64/""}"

#check if actual version is the same as the version to be downloaded
if [ "$1" == "$APPVER" ]; then
	echo "You are already running this version of go"
	exit 1
fi

#check if the version to be downloaded is lower than the actual version
if {
	echo "$1"
	echo "$APPVER"
} | sort --version-sort --check; then
	# check if --force flag is passed
	if [ "$2" != "--force" ]; then
		echo "You are trying to download a version that is lower than the actual version, to continue use --force flag"
		exit 1
	else
		echo "Forcing download"
	fi
fi

wget "https://dl.google.com/go/go$1.linux-amd64.tar.gz"
if [ "$?" -eq 0 ]; then
	sudo tar -xvf "go$1.linux-amd64.tar.gz"
	sudo rm -rf /usr/local/go
	sudo mv go /usr/local
	echo "Go $1 has been installed"
	exit 0
else
	echo "Go $1 could not be installed"
	exit 1
fi
