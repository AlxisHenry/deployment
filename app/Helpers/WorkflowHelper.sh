# This file contain all functions about workflow
# ==============================================

LocalApplications ()
{	
	applications=$(ls $LOCAL_ROOT_FOLDER);
	AppSelectionTemplate --l $applications;
}

DistantApplications ()
{
	applications=$(ssh $DIST_SERVER_USER@$DIST_SERVER_IP "ls $DIST_ROOT_FOLDER");
	AppSelectionTemplate --d $applications;
}

# @param {string} $choice
SelectLocalApplication ()
{
	echo ''
}

# @param {string} $choice
SelectDistantApplication ()
{
	echo ''
}

