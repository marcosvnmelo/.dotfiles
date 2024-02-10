#!/usr/bin/bash

# Get the list of modules

modules=$(ls -d */ | cut -f1 -d'/')

# Execute the init.sh file for each module

for module in $modules; do
	if [[ $module == \#* ]]; then
		continue
	fi

	bash -c "./$module/init.sh"
done
