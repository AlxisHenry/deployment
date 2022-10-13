#- This script will prepare code in dist folder for laravel project
#- ================================================================

#- Import environment variables
#- ============================
source .env;

# Clean useless folders/files
# ---------------------------
# @return {void}
clean () {
	# Files
	files=".editorconfig postcss.config.js tailwind.config.js vite.config.js package.json package-lock.json webpack.mix.js composer.lock";
	for file in $files; do
		rm -f $file;
	done
	# Scripts
	extensions="sh gitignore md bat";
	for extension in $extensions; do
		find -iname "*.$extension" -not -path "./vendor/*" -delete
	done
}

# Call functions
# --------------
# @return {void}
main () {
	clean;
}

cd $LOCAL_DIST_FOLDER/$(ls $LOCAL_DIST_FOLDER | grep -v -E '(.gitignore|readme.md)') && main;