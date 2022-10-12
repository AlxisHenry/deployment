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
		echo -e "\nCopying $LOCAL_ROOT_FOLDER/$app_name to $LOCAL_DIST_FOLDER/$app_name";
		rm -rf $LOCAL_DIST_FOLDER/$app_name; && mkdir -p $LOCAL_DIST_FOLDER/$app_name;
		elements=$(ls -A $LOCAL_ROOT_FOLDER/$app_name | grep -v -E '(.git|vendor|docs|*.sh|docker-compose.yml|*.md)')
		for el in $elements; do
			cp -r $LOCAL_ROOT_FOLDER/$app_name/$el $LOCAL_DIST_FOLDER/$app_name
		done
    elif [ "$app_type" == "--r" ]; then
		#- Check remote permissions
		#- Send dist folder content to remote server
		echo "a";
    fi
}
