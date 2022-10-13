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

    echo -e "
AUTOMATED DEPLOYMENT TOOL - v0.0.1

Github: https://github.com/AlxisHenry/deployment
Version: ${APP_VERSION}

GETTING STARTED

(\033[0;33mx-y\033[0m), (\033[0;33mx/y\033[0m) - Selectable values \e[3m(range, options)\e[0m
[\033[0;33mx\033[0m], [\033[0;33my\033[0m], [\033[0;33mnull\033[0m] - Default value
{ \033[0;33m:q\033[0m } - Cancel the program";

    if [ "$1" == "--l" ]; then
      echo -e "
DEPLOYABLE APPLICATIONS

Applications found in \033[1;35m$LOCAL_ROOT_FOLDER\033[0m
      "; 
    elif [ "$1" == "--r" ]; then
      echo -e "
TARGETS AVAIALBLE FOR DEPLOYMENT

Remote applications found in \033[1;35m$DIST_SERVER_USER@$DIST_SERVER_IP:$DIST_ROOT_FOLDER\033[0m
      ";     
    fi

    GenereteAppChoices $applications;

    echo -n -e "\nApplication (\033[0;33m1-${#arr[@]}\033[0m) [\033[0;33m:q\033[0m]: "; read application;
    
    if [ "$1" == "--l" ]; then
      local_app_name=$(echo $applications | cut -d ' ' -f $application 2>/dev/null);
      app_name=$local_app_name;
      app_type=$1;
      app=("$local_app_name","$app_type");
    elif [ "$1" == "--r" ]; then
      remote_app_name=$(echo $applications | cut -d ' ' -f $application 2>/dev/null);
      app_name=$remote_app_name;
      local_app_name=$(ls $LOCAL_DIST_FOLDER | grep -v -E '(.gitignore|readme.md)')
      app_type=$1;      
      app=("$remote_app_name","$local_app_name","$app_type");
    fi

    case $application in
      [1-${#arr[@]}]) echo -n -e "\nSelected application: \033[0;36m$app_name\033[0m. Please wait"; PrintDots; ManageApp $app; break;;
      ":q") ExitProgram; break;;  
    esac

  done
}