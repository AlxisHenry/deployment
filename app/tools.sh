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
	elif [ -d "$PATH_TO_DIST/$CURRENT_APP_NAME/public/shared" ]; then
		ConfigureCdnApplicaion;
	elif [ -f "$PATH_TO_DIST/$CURRENT_APP_NAME/symfony.lock" ]; then
		ConfigureSymfonyApplication;
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
	details "We noticed \033[0;36m${CURRENT_APP_NAME^^}\033[0m is built with Laravel." true;
	details "We will configure it for \033[0;36myou\033[0m.";
	bash $(dirname "$0")/scripts/laravel.sh ;
}

# Symfony configuration
# ---------------------
# @return {void}
ConfigureSymfonyApplication ()
{
	details "We noticed \033[0;36m${CURRENT_APP_NAME^^}\033[0m is built with Symfony." true;
	throw "This application is not yet fully supported by this tool.";
	bash $(dirname "$0")/scripts/symfony.sh > /dev/null 2>&1;
}

# Symfony configuration
# ---------------------
# @return {void}
ConfigureBasicApplication ()
{
	sleep 1;
	warning "This configuration is basic and may not be suitable for your application." true;
	sleep 2;
	bash $(dirname "$0")/scripts/base.sh > /dev/null 2>&1;
}

ConfigureCdnApplicaion ()
{
	sleep 1;
	details "We noticed \033[0;36m${CURRENT_APP_NAME^^}\033[0m is built with https://github.com/Alxishenry/cdn." true;
	details "We will configure it for \033[0;36myou\033[0m.";
	bash $(dirname "$0")/scripts/cdn.sh > /dev/null 2>&1;
}

# Change owner of remote app folder
# ---------------------------------
# @param {string} $remote_app_name
# @param {string} $2
# @param {?string} $3
# @return {?bool}
ChangeRemoteFolderOwner ()
{
	if [[ "$2" == "--deploy" ]]; then
		#- Give access to the remote user on the remote app folder
		ssh $REMOTE_SERVER_USER@$REMOTE_SERVER_IP "sudo -S chown -R $REMOTE_SERVER_USER:$REMOTE_SERVER_USER $REMOTE_PATH_TO_ROOT/$remote_app_name";
	elif [[ "$2" == "--apache" ]]; then
		if [[ "$3" == "--laravel" ]]; then
			#- Specific laravel rights
			ssh $REMOTE_SERVER_USER@$REMOTE_SERVER_IP "sudo -S chmod -R ugo-w $REMOTE_PATH_TO_ROOT/$remote_app_name/.";
			#- Specific access to laravel log file (for example: queue worker use it)
			ssh $REMOTE_SERVER_USER@$REMOTE_SERVER_IP "sudo -S chown -R ubuntu:www-data $REMOTE_PATH_TO_ROOT/$remote_app_name/storage";
			ssh $REMOTE_SERVER_USER@$REMOTE_SERVER_IP "sudo -S chmod -R ug+w $REMOTE_PATH_TO_ROOT/$remote_app_name/storage";
			return 0;
		fi
		#-
		ssh $REMOTE_SERVER_USER@$REMOTE_SERVER_IP "sudo -S chown -R www-data:www-data $REMOTE_PATH_TO_ROOT/$remote_app_name";
	fi

}

# Check remote rights
# -------------------
# @param {string} $remote_app_name
# @return {bool}
CheckRemoteRights ()
{
	ChangeRemoteFolderOwner $remote_app_name --deploy;
	#- Check if the user is the owner of the remote folder
	rights=$(ssh $REMOTE_SERVER_USER@$REMOTE_SERVER_IP "ls -ld $REMOTE_PATH_TO_ROOT/$remote_app_name | cut -d ' ' -f 3-4");
	for right in $rights; do
		if [ "$right" != "$REMOTE_SERVER_USER" ]; then
			UserDoesntHaveAccess;
			return 0;
		fi
	done
	#- Check if we can set the rights to the user
	ssh $REMOTE_SERVER_USER@$REMOTE_SERVER_IP "sudo chown -R ubuntu:ubuntu $REMOTE_PATH_TO_ROOT/$remote_app_name/" > /dev/null 2>&1;
	ssh $REMOTE_SERVER_USER@$REMOTE_SERVER_IP "sudo chmod ug+rwx $REMOTE_PATH_TO_ROOT/$remote_app_name/" > /dev/null 2>&1;
	if [ $? -eq 0 ]; then
		#- Check if the user has the right to write in the remote folder
		ssh $REMOTE_SERVER_USER@$REMOTE_SERVER_IP "touch $REMOTE_PATH_TO_ROOT/$remote_app_name/test.txt" > /dev/null 2>&1;
		if [ $? -eq 0 ]; then
			ssh $REMOTE_SERVER_USER@$REMOTE_SERVER_IP "rm $REMOTE_PATH_TO_ROOT/$remote_app_name/test.txt";
			return 0;
		else
			UserDoesntHaveAccess;
			return 0;
		fi
	else
		UserDoesntHaveAccess;
		return 0;
	fi
}

# Check remote rights
# -------------------
# @param {string} $remote_app_name
# @return {void}
SendAppToRemote ()
{
	rsync -azP --exclude-from $RSYNC_IGNORE -e 'ssh' $PATH_TO_DIST/$CURRENT_APP_NAME/ $REMOTE_SERVER_USER@$REMOTE_SERVER_IP:$REMOTE_PATH_TO_ROOT/$remote_app_name;
}

# Link remote storage folder to public
# ------------------------------------
# @param {string} $remote_app_name
# @return {void}
LinkRemoteStorageToPublicFolder ()
{
	ssh $REMOTE_SERVER_USER@$REMOTE_SERVER_IP "cd $REMOTE_PATH_TO_ROOT/$remote_app_name; php artisan storage:link;"
}

# Check if remote storage folder exist
# ------------------------------------
# @param {string} $remote_app_name
# @return {void}
CheckRemoteStorageFolder ()
{
	ssh $REMOTE_SERVER_USER@$REMOTE_SERVER_IP "ls -ld $REMOTE_PATH_TO_ROOT/$remote_app_name/storage" > /dev/null 2>&1;
	if [[ $? -ne 2 ]]; then
		details "Remote storage folder already exist. We remove the local folder." true;
		rm -rf $PATH_TO_DIST/$CURRENT_APP_NAME/storage;
  fi
}