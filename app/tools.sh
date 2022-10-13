#- This file will contain all tools functions
#- ==========================================

# Specific application tools
# --------------------------
# @return {void}
CheckIfAppIsSpecific ()
{
	CURRENT_APP_NAME=$(ls $PATH_TO_DIST | grep -v -E '(.gitignore|readme.md)');
	if [ -f "$PATH_TO_DIST/$CURRENT_APP_NAME/artisan" ]; then
		ConfigureLaravelApplication;
	else
		ConfigureBasicApplication;
	fi
}

# Laravel configuration
# ---------------------
# @return {void}
ConfigureLaravelApplication ()
{	
	sleep 1;
	echo -e "\n- We noticed \033[0;36m${CURRENT_APP_NAME^^}\033[0m is built with Laravel.";
	echo -e "- We will configure it for \033[0;36myou\033[0m.";
	bash scripts/laravel.sh ;
}

# Symfony configuration
# ---------------------
# @return {void}
ConfigureSymfonyApplication ()
{
	bash scripts/symfony.sh > /dev/null 2>&1;
}

# Symfony configuration
# ---------------------
# @return {void}
ConfigureBasicApplication ()
{
	bash scripts/base.sh > /dev/null 2>&1;
}