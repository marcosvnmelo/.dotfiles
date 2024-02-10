#!/usr/bin/bash

# Get the list of modules

modules=$(cat $PWD/modules)

# Execute the init.sh file for each module

for module in $modules; do
	if [[ $module == \#* ]]; then
		continue
	fi

	echo "Installing $module"
	# bash -c "./$module/init.sh"
done

fish -c "fish_update_completions"
