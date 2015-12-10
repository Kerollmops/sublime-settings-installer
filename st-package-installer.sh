#!/bin/sh

subl_settings_path="$HOME/Library/Application Support/Sublime Text 3"

# quit Sublime Text
killall "Sublime Text"

# clean directories
rm -rf $subl_settings_path
mkdir -p "$subl_settings_path/Installed Packages"
curl "https://packagecontrol.io/Package%20Control.sublime-package" > "$subl_settings_path/Installed Packages/Package Control.sublime-package"

# setting up folder
mkdir -p "$subl_settings_path/Packages/User"

# user settings
user_settings=$1
if [ -e $user_settings ]; then
	cp -f $user_settings "$subl_settings_path/Packages/User/Preferences.sublime-settings"
else
	echo "$user_settings file doesn't exist"
fi;

# install packages
if [ $# -eq 2 ]; then
	file_packs=$2
	if [ -e $file_packs ]; then
		cp $file_packs "$subl_settings_path/Packages/User/Package Control.sublime-settings"
	else
		echo "$file_packs file doesn't exist"
	fi;
fi;

# restart Sublime Text
open -a "Sublime Text"
