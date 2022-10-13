#- This file contain all functions about applications
#- ==================================================

# App selection
# -------------
# @param {string} $1
# @return {void}
Applications ()
{	
	if [ "$1" == "--l" ]; then
		#- Get all local applications
		applications=$(ls $LOCAL_ROOT_FOLDER);
		#- Display local applications
		AppSelectionTemplate --l $applications;
    elif [ "$1" == "--r" ]; then
		#- Get all remote applications
		applications=$(ssh $DIST_SERVER_USER@$DIST_SERVER_IP "ls $DIST_ROOT_FOLDER");
		#- Display remote applications
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
		echo -e "\nCopying $LOCAL_ROOT_FOLDER/\033[0;34m$local_app_name\033[0m to $LOCAL_DIST_FOLDER/\033[0;34m$local_app_name\033[0m";
		#- Delete the dist folder if exists and create a new one
		CreateAppDistFolder $local_app_name;
		#- Store directory/files to copy and exclude some files	
		elements=$(ls -A $LOCAL_ROOT_FOLDER/$local_app_name | grep -v -E '(.env|node_modules|.git|vendor|docs|*.sh|docker-compose.yml|*.md)')
		#- Copy the project to the dist folder
		for el in $elements; do
			cp -r $LOCAL_ROOT_FOLDER/$local_app_name/$el $LOCAL_DIST_FOLDER/$local_app_name
		done
		sleep 1;
		echo -e "Project \033[0;96m$local_app_name\033[0m copied to \033[0;34m$LOCAL_DIST_FOLDER/$local_app_name\033[0m";
		sleep 1;
		# Detect if it's a specific application 
		# CheckIfAppIsSpecific $local_app_name;
		echo -e "\n\033[0;32mOperation completed successfully.\033[0m\n";
		echo -e "\033[0;96m$local_app_name\033[0m is ready to be deployed on the server.\n";
		#- Press any key to continue the program
		while true; do
			echo -n -e "Press any key to continue (:q for cancel) [\033[0;33m:q\033[0m]: "; read m;
			case $m in
				:q) ExitProgram; break;;
				 *) break;;
			esac
		done
    elif [ "$app_type" == "--r" ]; then
		# Be sure you want to deploy the application
		echo $local_app_name;
	    while true; do
			echo -n -e "\nDo you want to deploy the application on the server? (y/n) [\033[0;33my\033[0m]: "; read m;
			case $m in
				[n/N]) ExitProgram; break;;
				*) break;;
			esac
		done
		# Check if you have the right to access the remote server
		# ...
		# Start the deployment
		echo -e "\nCopying $LOCAL_DIST_FOLDER/\033[0;34m$local_app_name\033[0m to $DIST_SERVER_USER@$DIST_SERVER_IP:$DIST_ROOT_FOLDER/\033[0;34m$remote_app_name\033[0m\n";
		#...
	fi
}
