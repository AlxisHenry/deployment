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
  rm -rf $PATH_TO_DIST/* ;
}

# Remove current app from dist folder
# -----------------------------------
# @param {string} $app_name
# @return {void}
RemoveAppFromDistFolder ()
{
  echo "removed"; 
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
  echo -e "\n\033[1;31mOperation canceled. The program will stop...\033[0m\n"; 
  sleep 1;
	exit;
}

# Do a break
# ----------
# @return {string} PressAnyKeyToContinue
PressAnyKeyToContinue ()
{
  read -n 1 -s -r -p "Press any key to continue";
  echo -e "\n";
}