#- This file will contain all utils functions
#- ==========================================

# Generate applications choices
# -----------------------------
# @param {string} $applications
# @return {string} $choices
GenereteAppChoices ()
{
  i=0;
	for app in $applications; do
		i=$(($i + 1))
		echo "$i. $app"
	done	
}

# Print Dots for loading
# ----------------------
# @return {string} $dots
PrintDots ()
{
  for i in {1..3}; do
    sleep 0.4;
    echo -n ".";
  done
  echo -e "";
}

# Reset dist app folder
# ---------------------
# @return {void}
ResetDistAppFolder ()
{
  rm -rf $PATH_TO_DIST/*;
  echo -e "*\n!.gitignore\n!.readme.md" > $PATH_TO_DIST/.gitignore;
}

# Remove current app from dist folder
# -----------------------------------
# @param {string} $app_name
# @return {void}
RemoveAppFromDistFolder ()
{
  rm -rf $PATH_TO_DIST/$app_name;
}

# Create a folder for the app
# ---------------------------
# @param {string} $app_name
# @return {void}
CreateAppDistFolder ()
{
  mkdir -p $PATH_TO_DIST/$app_name;
}

# Starter for functions
# ---------------------
# @return {void}
FunctionStarter ()
{
  clear;
}

# Exit program
# ------------
# @return {void}
ExitProgram ()
{
	throw "Operation canceled. The program will stop..."; 
}

# Do a break
# ----------
# @return {string} PressAnyKeyToContinue
PressAnyKeyToContinue ()
{
  read -n 1 -s -r -p "Press any key to continue";
  echo -e "\n";
}

# Do a break
# ----------
# @return {string} UserDoesntHaveAccess
UserDoesntHaveAccess ()
{ 
  warning "You don't have the right to write in the remote folder." true;
	warning "Please give the remote rights to $REMOTE_SERVER_USER and retry.";
	ExitProgram;
}

function throw() {
	echo -e "\n\033[0;31mError\033[0m: ${1}...\n";
	exit 1;
}

function warning() {
	if [[ -z ${1} ]]; then
		throw "call to warn function but no message provided";
	fi
	if [[ "${2}" == "true" ]]; then
		echo -e "";
	fi
	echo -e "\033[0;33mWarning\033[0m: ${1}";
}

function success () {
	if [[ -z ${1} ]]; then
		throw "call to success function but no message provided";
	fi
	if [[ "${2}" == "true" ]]; then
		echo -e "";
	fi
	echo -e "\033[0;32mSuccess\033[0m: ${1}";
}

function details () {
	if [[ -z ${1} ]]; then
		throw "call to info function but no message provided";
	fi
	if [[ "${2}" == "true" ]]; then
		echo -e "";
	fi
	echo -e "\033[0;94mDetails\033[0m: ${1}";
}

function debug () {
	if [[ -z ${1} ]]; then
		throw "call to debug function but no message provided";
	fi
	if [[ "${2}" == "true" ]]; then
		echo -e "";
	fi
	echo -e "\033[0;91mDebug\033[0m: ${1}";
}
