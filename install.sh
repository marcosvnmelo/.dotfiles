#!/bin/bash

# check if the script is run as root

# if [ "$(id -u)" != "0" ]; then
# 	echo "This script must be run as root" 1>&2
# 	exit 1
# fi

# Execute the init.sh file for each module

while IFS= read -r module; do
	if [[ $module == \#* ]]; then
		continue
	fi

	bash ./$module/init.sh
done <modules
