#- This file will contains all templates functions
#- ===============================================

# Display application selection template
# --------------------------------------
# @param {string} $1
# @param {string} $applications
# @return {void} 
AppSelectionTemplate ()
{ 
  #- New array of all applications
  arr=($applications);
  while true; do
    clear;
    AppStarterTemplate;
    if [ "$1" == "--l" ]; then
      LocalAppTemplate;
    elif [ "$1" == "--r" ]; then
      RemoteAppTemplate;   
    fi
    GenereteAppChoices $applications;
    echo -n -e "\nApplication (\033[0;33m1-${#arr[@]}\033[0m) [\033[0;33m:q\033[0m]: "; read application;
    app_type=$1;
    if [ "$1" == "--l" ]; then
      app_name=$(echo $applications | cut -d ' ' -f $application 2>/dev/null);
      app=("$app_name","$app_type");
    elif [ "$1" == "--r" ]; then
      remote_app_name=$(echo $applications | cut -d ' ' -f $application 2>/dev/null);
      local_app_name="$CURRENT_APP"
      app_name=$remote_app_name;
      app=("$remote_app_name","$local_app_name","$app_type");
    fi
    case $application in
      [1-${#arr[@]}]) echo -n -e "\nSelected application: \033[0;36m$app_name\033[0m. Please wait"; PrintDots; ManageApp $app; break;;
      ":q") ExitProgram; break;;  
    esac
  done
}

# Application base template
# -------------------------
# @return {string} AppStarterTemplate 
AppStarterTemplate ()
{
  echo -e "
AUTOMATED DEPLOYMENT TOOL - v0.0.1

Github: https://github.com/AlxisHenry/deployment
Version: ${APP_VERSION}

GETTING STARTED

(\033[0;33mx-y\033[0m), (\033[0;33mx/y\033[0m) - Selectable values \e[3m(range, options)\e[0m
[\033[0;33mx\033[0m], [\033[0;33my\033[0m], [\033[0;33mnull\033[0m] - Default value
{ \033[0;33m:q\033[0m } - Cancel the program";
}

# Local Applications base template
# --------------------------------
# @return {string} LocalAppTemplate 
LocalAppTemplate ()
{
  echo -e "
DEPLOYABLE APPLICATIONS

Applications found in \033[1;35m$PATH_TO_ROOT\033[0m
"; 
}

# Remote Applications base template
# ---------------------------------
# @return {string} RemoteAppTemplate 
RemoteAppTemplate ()
{
  echo -e "
TARGETS AVAIALBLE FOR DEPLOYMENT

Remote applications found in \033[1;35m$REMOTE_SERVER_USER@$REMOTE_SERVER_IP:$REMOTE_PATH_TO_ROOT\033[0m
";  
}