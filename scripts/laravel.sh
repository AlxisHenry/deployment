#- This script will prepare code in dist folder for laravel project
#- ================================================================

#- Import environment variables
#- ============================
source .env;

# Install dependencies
# --------------------
# @param {string} $1
# @return {void}
dependencies () {
	if [ "$1" == "--production" ]; then
		rm -rf vendor/ node_modules/;
		composer install --no-dev --optimize-autoloader && npm install --omit=dev;
    elif [ "$1" == "--development" ]; then
		#- All dependencies are needed for build process
		composer install && npm install;
    fi
}

# Laravel specific setup
# ----------------------
# @return {void}
laravel () {
	# Clearing cached files
	php artisan optimize:clear;
	# Delete session files
	rm -f storage/framework/sessions/*;
	# Clear logs
	rm -f storage/logs/laravel.log;
}

# Build assets
# -------------
# @return {void}
build () {
	npm run build;
}

# Clean useless folders/files
# ---------------------------
# @return {void}
clean () {
	# Folders
	folders="resources/js resources/scss";
	for folder in $folders; do
		rm -rf $folder;
	done
	# Files
	files=".editorconfig postcss.config.js tailwind.config.js vite.config.js package.json package-lock.json webpack.mix.js composer.lock";
	for file in $files; do
		rm -f $file;
	done
	# Scripts
	scripts="sh gitignore md bat";
	for script in $scripts; do
		find -iname "*.$script" -not -path "./vendor/*" -delete
	done
}

# Call functions
# --------------
# @return {void}
main () {
	dependencies --development;
	laravel;
	build;
	dependencies --production;
	clean;
}

cd $LOCAL_DIST_FOLDER/$(ls $LOCAL_DIST_FOLDER | grep -v -E '(.gitignore|readme.md)') && main;