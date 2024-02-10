#!/bin/bash

# Execute the init.sh file for each module

while read module; do
	if [[ $module == \#* ]]; then
		continue
	fi

	bash ./$module/init.sh
done <modules
