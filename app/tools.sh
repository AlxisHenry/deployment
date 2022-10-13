#- This file will contain all tools functions
#- ==========================================

# Specific application tools
# -------------
# @param {string} app_name
# @return {void}
CheckIfAppIsSpecific ()
{
	# todo : Check if its a laravel app
	ConfigureLaravelApplication;
}

# Laravel configuration
# -------------
# @return {void}
ConfigureLaravelApplication ()
{
	bash scripts/laravel.sh > /dev/null 2>&1;
}

# Symfony configuration
# -------------
# @return {void}
ConfigureSymfonyApplication ()
{
	bash scripts/symfony.sh > /dev/null 2>&1;
}

# Symfony configuration
# -------------
# @return {void}
ConfigureBasicApplication ()
{
	bash scripts/base.sh > /dev/null 2>&1;
}