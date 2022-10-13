#- This file contain all functions about applications
#- ==================================================

# App selection
# -------------
# @param {string} $1
# @return {void}
Applications ()
{	
	if [ "$1" == "--l" ]; then
		applications=$(ls $PATH_TO_ROOT);
		AppSelectionTemplate --l $applications;
    elif [ "$1" == "--r" ]; then
		applications=$(ssh $REMOTE_SERVER_USER@$REMOTE_SERVER_IP "ls $REMOTE_PATH_TO_ROOT");
		AppSelectionTemplate --r $applications;
    fi
}

# Manage application
# ------------------
# @param {Array<string>} $app
# @return {void}
ManageApp ()
{
	if [ "$app_type" == "--l" ]; then
		#- RECOVERY
		echo -e "\n\033[0;36m${app_name^^}\033[0m - RECOVERY";
		CreateAppDistFolder $app_name;
		elements=$(ls -A $PATH_TO_ROOT/$app_name | grep -v -E '(.env|node_modules|.git|vendor|docs|*.sh|docker-compose.yml|*.md)')
		for el in $elements; do
			cp -r $PATH_TO_ROOT/$app_name/$el $PATH_TO_DIST/$app_name
		done
		sleep 1;
		echo -e "\n\033[0;32mRecovery completed successfully.\033[0m";
		# - CONFIGURATION
		echo -e "\n\033[0;36m${app_name^^}\033[0m - CONFIGURATION";
		CheckIfAppIsSpecific;
		sleep 1;
		echo -e "\n\033[0;32mConfiguration completed successfully.\033[0m";
		echo -e "\n\033[0;36m${app_name^^}\033[0m - READY TO BE DEPLOYED\n";
		PressAnyKeyToContinue;
    elif [ "$app_type" == "--r" ]; then

		# DEPLOYMENT
	    while true; do
			echo -n -e "\nDo you want to deploy the application ? (y/n) [\033[0;33my\033[0m]: "; read m;
			case $m in
				[n/N]) ExitProgram; break;;
				*) break;;
			esac
		done
		echo -e "\n\033[0;36m${local_app_name^^}\033[0m - DEPLOYMENT";
		sleep 1;
		echo -e "\n\033[0;32mDeployment completed successfully.\033[0m";
		sleep 1;
		echo -e "\n\033[0;36m${local_app_name^^}\033[0m - DEPLOYED\n";
		PressAnyKeyToContinue;
	fi
}
