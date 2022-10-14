#- This file contain all functions about applications
#- ==================================================

# App selection
# -------------
# @param {string} $1
# @return {void}
Applications ()
{	
	if [ "$1" == "--local" ]; then
		applications=$(ls $PATH_TO_ROOT);
		AppSelectionTemplate --local $applications;
    elif [ "$1" == "--remote" ]; then
		applications=$(ssh $REMOTE_SERVER_USER@$REMOTE_SERVER_IP "ls $REMOTE_PATH_TO_ROOT");
		AppSelectionTemplate --remote $applications;
    fi
}

# Manage application
# ------------------
# @param {Array<string>} $app
# @return {void}
ManageApp ()
{
	if [ "$app_type" == "--local" ]; then
		#- RECOVERY
		echo -e "\n\033[0;36m${app_name^^}\033[0m - RECOVERY";
		CreateAppDistFolder $app_name;
		elements=$(ls -A $PATH_TO_ROOT/$app_name | grep -v -E '(node_modules|.git|vendor|docs|*.sh|docker-compose.yml|*.md)')
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
    elif [ "$app_type" == "--remote" ]; then
		# DEPLOYMENT
	    while true; do
			echo -n -e "\nDo you want to deploy the application ? (y/n) [\033[0;33my\033[0m]: "; read m;
			case $m in
				[n/N]) ExitProgram; break;;
				*) break;;
			esac
		done
		echo -e "\n\033[0;36m${local_app_name^^}\033[0m - DEPLOYMENT";
		CheckRemoteRights $remote_app_name;
		SendAppToRemote $remote_app_name > /dev/null 2>&1;
		if [ -f "$PATH_TO_DIST/$CURRENT_APP_NAME/artisan" ]; then
			ChangeRemoteFolderOwner $remote_app_name --apache --laravel
		else 
			ChangeRemoteFolderOwner $remote_app_name --apache
		fi
		sleep 1;
		echo -e "\n\033[0;32mDeployment completed successfully.\033[0m";
		sleep 1;
		echo -e "\n\033[0;36m${local_app_name^^}\033[0m - DEPLOYED\n";
		PressAnyKeyToContinue;
	fi
}
