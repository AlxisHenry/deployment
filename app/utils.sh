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
	exit;
}
