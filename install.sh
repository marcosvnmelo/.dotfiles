#!/bin/bash

# Execute the init.sh file for each module

while read module; do
	if [[ $module == \#* ]]; then
		continue
	fi

	bash -c "./$module/init.sh"
done <modules
