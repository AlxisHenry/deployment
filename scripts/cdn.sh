#!/bin/bash

#- This script will prepare code in dist folder for laravel project
#- ================================================================

#- Import environment variables
#- ============================
source $(dirname "$0")/p.env;

# Install dependencies
# --------------------
# @param {string} $1
# @return {void}
dependencies () {
	rm -rf vendor/ node_modules/;
	if [ "$1" == "--production" ]; then
		composer install --no-dev --optimize-autoloader;
  elif [ "$1" == "--development" ]; then
		#- All dependencies are needed for build process
		composer install;
  fi
}

# Clean useless folders/files
# ---------------------------
# @return {void}
clean () {
	# Folders
	folders="utils uploads tests";
	for folder in $folders; do
		rm -rf $folder;
	done
	# Files
	files=".editorconfig Dockerfile composer.json composer.lock package.json package-lock.json";
	for file in $files; do
		rm -f $file;
	done
	# Scripts
	extensions="sh gitignore md bat env";
	for extension in $extensions; do
		find -iname "*.$extension" -not -path "./vendor/*" -delete
	done
}

# Call functions
# --------------
# @return {void}
main () {
	dependencies --production;
	clean;
}

cd $PATH_TO_DIST/$CURRENT_APP_NAME && main > /dev/null 2>&1;
