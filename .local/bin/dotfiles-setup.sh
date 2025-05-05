#!/bin/sh

# Setupscript for automatic systemlinking of files

# TODO:
# - Update the dotfiles repo
# - Set variable of base location
# - Set determine hostname
# - Dynamically find all files in the base location and syslink to correct file

dir="${XDG_DATA_HOME:-$HOME/.local/share}/dotfiles"

[ ! -d $dir ] && mkdir $dir

#for file in $dir/$(hostname -s)/*; do
	#echo "${file}"
#done

find $dir -maxdepth 4 -type f -exec \
	sed -i '' "s|\${dir}/\$(hostname -s)||" {} \;





	#dirname {} \
