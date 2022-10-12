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
    if [ "$1" == "--l" ]; then
      echo -e "\033[0;34mLocal application selection\033[0m\n";  
      echo -e "\e[3mPlease enter your choice number\e[0m [\033[0;33m1-${#arr[@]}\033[0m]\n";
    elif [ "$1" == "--r" ]; then
      echo -e "\033[0;34mRemote application selection\033[0m\n";  
    fi
    GenereteAppChoices $applications;
    echo -n -e "\nChoose the desired application (:q for cancel) [\033[0;33m:q\033[0m]: "; read application;
    app_name="$(echo $applications | cut -d ' ' -f $application)";
    app_type=$1;
    app=("$app_name","$app_type");
    case $application in
      [1-${#arr[@]}]*) echo -n -e "\nSelected application : \033[0;96m$app_name\033[0m. Please wait"; PrintDots; ManageApp $app; break;;
      *) echo -e "\n\033[1;31mOperation Canceled. The program will stop...\033[0m\n"; sleep 1; ExitProgram; break;;
    esac
  done
}