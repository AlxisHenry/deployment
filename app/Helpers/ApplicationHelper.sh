#- This file contain all functions about applications
#- ==================================================

# App selection
# -------------
# @param {string} $1
# @return {void}
Applications ()
{	
	if [ "$1" == "--l" ]; then
		applications=$(ls $LOCAL_ROOT_FOLDER);
		AppSelectionTemplate --l $applications;
    elif [ "$1" == "--r" ]; then
		applications=$(ssh $DIST_SERVER_USER@$DIST_SERVER_IP "ls $DIST_ROOT_FOLDER");
		AppSelectionTemplate --r $applications;
    fi
}

# Manage application
# ------------------
# @param {Array<?string>} $app
# @return {void}
ManageApp ()
{
	if [ "$app_type" == "--l" ]; then

		#- RECOVERY
		echo -e "\n\033[0;36m${app_name^^}\033[0m - RECOVERY";
		CreateAppDistFolder $local_app_name;
		elements=$(ls -A $LOCAL_ROOT_FOLDER/$local_app_name | grep -v -E '(.env|node_modules|.git|vendor|docs|*.sh|docker-compose.yml|*.md)')
		for el in $elements; do
			cp -r $LOCAL_ROOT_FOLDER/$local_app_name/$el $LOCAL_DIST_FOLDER/$local_app_name
		done
		sleep 1;
		echo -e "\n\033[0;32mRecovery completed successfully.\033[0m";

		# - CONFIGURATION
		echo -e "\n\033[0;36m${app_name^^}\033[0m - CONFIGURATION";
		CheckIfAppIsSpecific $local_app_name;
		sleep 1;
		echo -e "\n\033[0;32mConfiguration completed successfully.\033[0m";
		echo -e "\n\033[0;36m${app_name^^}\033[0m - READY TO BE DEPLOYED\n";
		#- Press any key to continue the program
		while true; do
			echo -n -e "Press any key to continue (\033[0;33m*/:q\033[0m) [\033[0;33mcontinue\033[0m]: "; read m;
			case $m in
				:q) ExitProgram; break;;
				 *) break;;
			esac
		done

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

	fi
}
