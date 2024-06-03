#!/usr/bin/bash

# Get the list of modules

modules=$(cat "$PWD"/modules)

if [ $# -eq 0 ]; then

	# Execute the init.sh file for each module
	for module in $modules; do
		if [[ $module == \#* ]]; then
			continue
		fi

		bash -c "./$module/init.sh"
	done

else
	bash -c "./$1/init.sh"
fi

fish -c "fish_update_completions"
